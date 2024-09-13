class PagesController < ApplicationController
  def home
    @teams = Team.all
  end

  def schedule
    @weeks = Week.includes(games: [:home_team, :away_team]).order(:number)
  end

  def standings
    @teams = Team.order(wins: :desc, points_for: :desc) 
  end
end
