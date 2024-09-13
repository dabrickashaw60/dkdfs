class TeamsController < ApplicationController
  def index
    @teams = Team.all.order(wins: :desc)
  end
end
