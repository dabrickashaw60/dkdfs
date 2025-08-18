class Week < ApplicationRecord
  has_many :games
  has_many :drafted_player_week_stats, dependent: :destroy
  has_many :week_team_lineups, dependent: :destroy  
end
