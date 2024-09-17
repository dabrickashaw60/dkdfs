class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @teams = Team.all
    @weeks = Week.all
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
  
end
