class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @season = params[:season] || "2025-2026"
    @teams = TeamSeason.includes(:team).where(season: @season).order('teams.name')
    @weeks = Week.where(season: @season)
    @available_seasons = TeamSeason.distinct.pluck(:season).sort.reverse
  end


  private

  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
  
end
