class Week < ApplicationRecord
  THANKSGIVING_NUMBER = 100
  CHRISTMAS_NUMBER    = 200

  has_many :games
  has_many :drafted_player_week_stats, dependent: :destroy
  has_many :week_team_lineups, dependent: :destroy  

  def special_slate?
    [THANKSGIVING_NUMBER, CHRISTMAS_NUMBER].include?(number)
  end

  def label
    case number
    when THANKSGIVING_NUMBER
      "Thanksgiving"
    when CHRISTMAS_NUMBER
      "Christmas"
    else
      "Week #{number}"
    end
  end
end
