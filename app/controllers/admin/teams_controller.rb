class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @teams = Team.all
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    
    if @team.update(team_params)
      flash[:notice] = "Team updated successfully!"
      redirect_to admin_dashboard_path # Redirect to the dashboard or another appropriate path
    else
      flash[:alert] = "There was a problem updating the team."
      render :edit
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :dollars_owed, :dollars_won, :wins, :losses, :ties, :points_for, :points_against, :highest_week)
  end

  def authenticate_admin!
    unless current_user.admin? # assuming you have an `admin` boolean in your User model
      flash[:alert] = "You are not authorized to access this section."
      redirect_to root_path
    end
  end
  
end
