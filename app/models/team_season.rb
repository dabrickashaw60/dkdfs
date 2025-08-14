# app/models/team_season.rb
class TeamSeason < ApplicationRecord
  belongs_to :team

  def total_points_for
    team.home_games.where(season: season).sum(:home_score) +
    team.away_games.where(season: season).sum(:away_score)
  end

  def total_points_against
    team.home_games.where(season: season).sum(:away_score) +
    team.away_games.where(season: season).sum(:home_score)
  end

  def update_highest_week
    games = team.all_games.where(season: season)

    highest_score = 0
    highest_week = nil

    games.each do |game|
      score = game.home_team_id == team.id ? game.home_score : game.away_score
      if score && score > highest_score
        highest_score = score
        highest_week = game.week.number
      end
    end

    if highest_week
      puts "Updating #{team.name} to #{highest_score} (#{highest_week})"
      update(highest_week: "#{highest_score} (#{highest_week})")
    else
      puts "No score for #{team.name} in #{season}"
    end
  end


end
