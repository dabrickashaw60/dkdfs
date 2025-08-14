class Team < ApplicationRecord
  has_many :home_games, class_name: "Game", foreign_key: "home_team_id"
  has_many :away_games, class_name: "Game", foreign_key: "away_team_id"
  has_many :team_seasons

  def all_games(season = nil)
    scope = Game.where("home_team_id = ? OR away_team_id = ?", id, id)
    season ? scope.where(season: season) : scope
  end

  def for_season(season)
    team_seasons.find_by(season: season)
  end


end
