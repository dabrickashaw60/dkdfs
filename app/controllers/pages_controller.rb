class PagesController < ApplicationController
  def home
    @season = params[:season] || "2025-2026"
    @available_seasons = TeamSeason.distinct.pluck(:season).sort.reverse

    @teams = TeamSeason.includes(:team)
                      .where(season: @season)
                      .order('teams.name') # optional: alphabetical order
  end

  def schedule
    @season = params[:season] || "2025-2026"

    @weeks = Week.includes(games: [:home_team, :away_team])
                .where(season: @season)
                .order(:number)

    @available_seasons = Week.distinct.pluck(:season).sort.reverse
    
    requested_week = params[:week_number].to_i if params[:week_number].present?
    valid_numbers  = @weeks.map(&:number)
    
    # Find the first week where every game is unscored (nil or 0)
    incomplete_week = @weeks.detect do |w|
      w.games.all? do |g|
        (g.home_score.nil? || g.home_score.to_f.zero?) &&
        (g.away_score.nil? || g.away_score.to_f.zero?)
      end
    end
    
    week_number =
      if valid_numbers.include?(requested_week)
        requested_week
      elsif incomplete_week
        incomplete_week.number
      else
        valid_numbers.last
      end
    
    @default_week_number = week_number
    @selected_week = @weeks.find { |w| w.number == week_number }


    if @selected_week
      @team_lineups = WeekTeamLineup.includes(:team)
                                    .where(week: @selected_week)
                                    .order(points: :desc)

      @drafted_stats = DraftedPlayerWeekStat.includes(:player)
                                            .where(week: @selected_week)
                                            .order(pct_drafted: :desc, fpts: :desc)

      # fast lookup for lineup mini-table badges
      @stats_by_name = @drafted_stats.each_with_object({}) do |s, h|
        key = s.player.name.to_s.strip.gsub(/\s+/, ' ')
        h[key] = { pct: s.pct_drafted.to_f, fpts: s.fpts.to_f, pos: s.roster_position }
      end
    else
      @team_lineups = []
      @drafted_stats = []
      @stats_by_name = {}
    end
  end


  def standings
    @season = params[:season] || "2025-2026"

    @teams = TeamSeason.includes(:team)
                      .where(season: @season)
                      .sort_by { |ts| [-(ts.wins || 0), -(ts.points_for || 0)] }


    @available_seasons = TeamSeason.distinct.pluck(:season).sort.reverse
  end

  private

  def normalize_name(name)
    name.to_s.strip.gsub(/\s+/, ' ')
  end

end
