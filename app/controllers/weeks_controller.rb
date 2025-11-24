require "csv"
class WeeksController < ApplicationController
  def show
    @week = Week.find(params[:id])
    @games = @week.games
    @default_week_number = 4
  end

  def upload_csv_form
    # Just render the form for uploading the CSV
  end

  def upload_csv
    season = params[:season]
    @week  = Week.find_by(number: params[:week_number], season: season)

    if @week && params[:file].present?
      Rails.logger.info("Starting CSV upload for Week #{params[:week_number]}, Season #{season}")

      csv_table = CSV.read(params[:file].path, headers: true)

      if @week.special_slate?
        Rails.logger.info("Processing special slate week (#{@week.label}) for Season #{season}")

        ActiveRecord::Base.transaction do
          upsert_week_team_lineups_with_ensure!(@week, csv_table, season)
          upsert_drafted_player_week_stats!(@week, csv_table)
        end

        flash[:notice] = "#{@week.label} slate uploaded successfully (lineups and player stats only; standings unchanged)."
        return redirect_to upload_csv_weeks_path
      end


      ActiveRecord::Base.transaction do
        # === 1) Update game scores (now ensuring Team + TeamSeason) ===
        csv_table.each do |row|
          team_name = row['EntryName'].to_s.strip
          next if team_name.blank?

          team, _ts = EnsureTeamSeason.call(team_name: team_name, season: season)

          game = @week.games.find_by(home_team_id: team.id) || @week.games.find_by(away_team_id: team.id)
          next unless game

          points = row['Points'].to_s.delete(',').to_f
          if game.home_team_id == team.id
            game.update!(home_score: points)
          else
            game.update!(away_score: points)
          end
        end

        # === 2) Per-team lineup text (col 4) + points ===
        upsert_week_team_lineups_with_ensure!(@week, csv_table, season)

        # === 3) League-wide player rows (cols 5–8) ===
        upsert_drafted_player_week_stats!(@week, csv_table)
      end

      update_week_results(@week, season)
      flash[:notice] = "Scores and CSV extras for Week #{params[:week_number]} uploaded successfully!"
    else
      flash[:alert] = "Invalid week, season, or file."
    end

    redirect_to upload_csv_weeks_path
  end


  private

  def update_week_results(week, season)
    return if week.special_slate?
    week.games.find_each do |game|
      home_team = game.home_team
      away_team = game.away_team

      home_season = TeamSeason.find_or_create_by(team: home_team, season: season)
      away_season = TeamSeason.find_or_create_by(team: away_team, season: season)

      # Raw scores (could be nil)
      hs_raw = game.home_score
      as_raw = game.away_score

      # Treat nil OR 0 as "forgot lineup"
      hs = hs_raw.to_f if hs_raw
      as = as_raw.to_f if as_raw
      hs ||= 0.0
      as ||= 0.0

      forgot_home = hs_raw.nil? || hs.zero?
      forgot_away = as_raw.nil? || as.zero?

      # --- Determine result ---
      if forgot_home && forgot_away
        # Both forgot => tie
        home_season.increment!(:ties)
        away_season.increment!(:ties)
      elsif forgot_home && !forgot_away
        # Home forgot, away didn't => away wins
        away_season.increment!(:wins)
        home_season.increment!(:losses)
      elsif !forgot_home && forgot_away
        # Away forgot, home didn't => home wins
        home_season.increment!(:wins)
        away_season.increment!(:losses)
      else
        # Both submitted lineups => normal compare
        if hs > as
          home_season.increment!(:wins)
          away_season.increment!(:losses)
        elsif as > hs
          away_season.increment!(:wins)
          home_season.increment!(:losses)
        else
          home_season.increment!(:ties)
          away_season.increment!(:ties)
        end
      end

      # --- Points for/against (use 0 for the side that forgot) ---
      home_season.increment!(:points_for, hs)
      home_season.increment!(:points_against, as)
      away_season.increment!(:points_for, as)
      away_season.increment!(:points_against, hs)

      # --- Highest week (only for non-forgot scores) ---
      if !forgot_home && hs > (home_season.highest_week.to_s[/\d+\.?\d*/].to_f || 0)
        home_season.update!(highest_week: "#{hs} (#{week.number})")
      end
      if !forgot_away && as > (away_season.highest_week.to_s[/\d+\.?\d*/].to_f || 0)
        away_season.update!(highest_week: "#{as} (#{week.number})")
      end
    end
  end


  def upsert_week_team_lineups_with_ensure!(week, csv_table, season)
    csv_table.each do |row|
      team_name = row['EntryName'].to_s.strip
      next if team_name.blank?

      team, _ts = EnsureTeamSeason.call(team_name: team_name, season: season)

      lineup_text = row['Lineup'].to_s.strip

      points_raw = row['Points']
      points_val = points_raw.to_s.delete(',')
      points     = Float(points_val) rescue nil

      record = WeekTeamLineup.find_or_initialize_by(week: week, team: team)
      record.lineup_text = lineup_text if lineup_text.present?
      record.points      = points unless points.nil?
      record.save!
    end
  end

  def upsert_drafted_player_week_stats!(week, csv_table)
    csv_table.each do |row|
      player_name = row['Player'].to_s.strip
      next if player_name.blank?

      roster_pos = row['Roster Position'].to_s.strip
      pct_raw    = row['%Drafted'].to_s.strip.delete('%,')
      fpts_raw   = row['FPTS'].to_s.strip.delete(',')

      pct_drafted = Float(pct_raw) rescue nil
      fpts        = Float(fpts_raw) rescue nil

      player = Player.find_or_create_by!(name: normalize_name(player_name))

      stat = DraftedPlayerWeekStat.find_or_initialize_by(week: week, player: player)
      stat.roster_position = roster_pos if roster_pos.present?
      stat.pct_drafted     = pct_drafted unless pct_drafted.nil?
      stat.fpts            = fpts unless fpts.nil?
      stat.save!
    end
  end

  def normalize_name(name)
    name.to_s.strip.gsub(/\s+/, ' ')
  end

end
