class WeeksController < ApplicationController
  def show
    @week = Week.find(params[:id])
    @games = @week.games
  end

  def upload_csv_form
    # Just render the form for uploading the CSV
  end

  def upload_csv
    @week = Week.find_by(number: params[:week_number])
  
    if @week && params[:file].present?
      Rails.logger.info("Starting CSV upload for Week #{params[:week_number]}")
      
      CSV.foreach(params[:file].path, headers: true) do |row|
        team_name = row['EntryName']
        next if team_name.blank? # Skip rows with missing team names
  
        team = Team.find_by(name: team_name)
  
        if team.present?
          game = @week.games.find_by(home_team: team) || @week.games.find_by(away_team: team)
  
          if game.present?
            if game.home_team == team
              Rails.logger.info("Updating home score for team: #{team.name}, Points: #{row['Points']}")
              game.update(home_score: row['Points'].to_f)
            else
              Rails.logger.info("Updating away score for team: #{team.name}, Points: #{row['Points']}")
              game.update(away_score: row['Points'].to_f)
            end
          else
            Rails.logger.info("Game not found for team: #{team.name}")
          end
        else
          Rails.logger.info("Team not found: #{team_name}")
        end
      end
  
      update_week_results(@week) # Update wins, losses, and ties based on the current week
      flash[:notice] = "Scores for Week #{params[:week_number]} uploaded successfully!"
    else
      flash[:alert] = "Invalid week or file"
    end
  
    redirect_to root_path
  end

  private

def update_week_results(week)
  Rails.logger.info("Updating results for week #{week.number}")
  
  week.games.each do |game|
    home_team = game.home_team
    away_team = game.away_team

    if game.home_score && game.away_score
      if game.home_score > game.away_score
        Rails.logger.info("Home team wins: #{home_team.name} (#{game.home_score} > #{game.away_score})")
        home_team.increment!(:wins)
        away_team.increment!(:losses)
      elsif game.away_score > game.home_score
        Rails.logger.info("Away team wins: #{away_team.name} (#{game.away_score} > #{game.home_score})")
        away_team.increment!(:wins)
        home_team.increment!(:losses)
      else
        Rails.logger.info("Game tied between #{home_team.name} and #{away_team.name}")
        home_team.increment!(:ties)
        away_team.increment!(:ties)
      end

      # Update points for and points against
      home_team.increment!(:points_for, game.home_score)
      home_team.increment!(:points_against, game.away_score)
      away_team.increment!(:points_for, game.away_score)
      away_team.increment!(:points_against, game.home_score)

      # Update highest week score
      home_team.update_highest_week
      away_team.update_highest_week
    else
      Rails.logger.info("Game incomplete: #{home_team.name} vs. #{away_team.name}")
    end
  end
end

  
  
  
end
