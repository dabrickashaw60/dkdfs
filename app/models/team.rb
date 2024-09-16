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
    # Fetch all games where the team is either home or away
    games = Game.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)

    highest_score = 0
    highest_week = nil

    # Loop through each game and calculate the highest score
    games.each do |game|
      # Check if the team is home or away and get the relevant score
      if game.home_team_id == self.id
        current_score = game.home_score
      else
        current_score = game.away_score
      end

      # Update highest score and week if the current score is greater
      if current_score && current_score > highest_score
        highest_score = current_score
        highest_week = game.week.number
      end
    end

    # Update the team's highest_week attribute with score and week number
    if highest_week
      self.update(highest_week: "#{highest_score} (Week #{highest_week})")
    end
  end
  
end
