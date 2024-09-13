class SchedulesController < ApplicationController
  def index
    @weeks = Week.includes(games: [:home_team, :away_team]).order(:number)
  end
end
