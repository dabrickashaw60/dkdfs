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
    @week = Week.find_by(number: params[:week_number], season: season)

    if @week && params[:file].present?
      Rails.logger.info("Starting CSV upload for Week #{params[:week_number]}, Season #{season}")

      CSV.foreach(params[:file].path, headers: true) do |row|
        team_name = row['EntryName']
        next if team_name.blank?

        team = Team.find_by(name: team_name)
        next unless team

        game = @week.games.find_by(home_team: team) || @week.games.find_by(away_team: team)
        next unless game

        if game.home_team == team
          game.update(home_score: row['Points'].to_f)
        else
          game.update(away_score: row['Points'].to_f)
        end
      end

      update_week_results(@week, season)
      flash[:notice] = "Scores for Week #{params[:week_number]} uploaded successfully!"
    else
      flash[:alert] = "Invalid week, season, or file."
    end

    redirect_to root_path
  end


  private

  def update_week_results(week, season)
    week.games.each do |game|
      home_team = game.home_team
      away_team = game.away_team

      home_season = TeamSeason.find_or_create_by(team: home_team, season: season)
      away_season = TeamSeason.find_or_create_by(team: away_team, season: season)

      if game.home_score.present? && game.away_score.present?
        home_score = game.home_score.to_f
        away_score = game.away_score.to_f

        # Determine win/loss/tie
        if home_score > away_score
          home_season.increment!(:wins)
          away_season.increment!(:losses)
        elsif away_score > home_score
          away_season.increment!(:wins)
          home_season.increment!(:losses)
        else
          home_season.increment!(:ties)
          away_season.increment!(:ties)
        end

        # Update points for/against
        home_season.increment!(:points_for, home_score)
        home_season.increment!(:points_against, away_score)
        away_season.increment!(:points_for, away_score)
        away_season.increment!(:points_against, home_score)

        # Update highest week score
        if home_score > (home_season.highest_week.to_s[/\d+\.?\d*/].to_f || 0)
          home_season.update!(highest_week: "#{home_score} (#{week.number})")
        end

        if away_score > (away_season.highest_week.to_s[/\d+\.?\d*/].to_f || 0)
          away_season.update!(highest_week: "#{away_score} (#{week.number})")
        end

      end
    end
  end

  
end
