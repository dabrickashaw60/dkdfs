class Team < ApplicationRecord
  has_many :home_games, class_name: "Game", foreign_key: "home_team_id"
  has_many :away_games, class_name: "Game", foreign_key: "away_team_id"

    # Calculate total points_for
    def total_points_for
      home_games.sum(:home_score) + away_games.sum(:away_score)
    end
  
    # Calculate total points_against
    def total_points_against
      home_games.sum(:away_score) + away_games.sum(:home_score)
    end

  def all_games
    Game.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def update_highest_week
    highest_game = Game.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
                       .select("games.*, greatest(home_score, away_score) as max_score")
                       .order('max_score DESC').first
    
    if highest_game
      max_score = self.id == highest_game.home_team_id ? highest_game.home_score : highest_game.away_score
      week_number = highest_game.week.number
      
      self.update(highest_week: "#{max_score} (Week #{week_number})")
    end
  end
  
end
