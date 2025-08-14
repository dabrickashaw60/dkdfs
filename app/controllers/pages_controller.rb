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
    @default_week_number = 1
  end

  def standings
    @season = params[:season] || "2025-2026"

    @teams = TeamSeason.includes(:team)
                      .where(season: @season)
                      .sort_by { |ts| [-(ts.wins || 0), -(ts.points_for || 0)] }


    @available_seasons = TeamSeason.distinct.pluck(:season).sort.reverse
  end

end
