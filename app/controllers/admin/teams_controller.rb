class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @teams = Team.all
  end

  def edit
    @team = Team.find(params[:id])
    @season = params[:season] || "2025-2026"
    @team_season = @team.team_seasons.find_by(season: @season)
  end

  def update
    @team = Team.find(params[:id])
    @season = params[:season]
    @team_season = @team.team_seasons.find_by(season: @season)

    if @team_season.update(team_season_params)
      flash[:notice] = "Team season updated successfully!"
      redirect_to admin_dashboard_path(season: @season)
    else
      flash[:alert] = "There was a problem updating the team season."
      render :edit
    end
  end

  private

  def team_season_params
    params.require(:team_season).permit(:dollars_owed, :dollars_won, :wins, :losses, :ties, :points_for, :points_against, :highest_week)
  end

  def authenticate_admin!
    unless current_user.admin? # assuming you have an `admin` boolean in your User model
      flash[:alert] = "You are not authorized to access this section."
      redirect_to root_path
    end
  end
  
end
