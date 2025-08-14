class TeamsController < ApplicationController
  def index
    @season = params[:season] || "2025-2026"

    @team_seasons = TeamSeason.includes(:team)
                              .where(season: @season)
                              .order(wins: :desc, points_for: :desc)
  end
end
