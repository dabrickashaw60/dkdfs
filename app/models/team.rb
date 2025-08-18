class Team < ApplicationRecord
  has_many :home_games, class_name: "Game", foreign_key: "home_team_id"
  has_many :away_games, class_name: "Game", foreign_key: "away_team_id"
  has_many :team_seasons
  has_many :week_team_lineups, dependent: :destroy

  before_validation :normalize_name!

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Case-insensitive finder that also normalizes whitespace
  def self.find_ci_by_name(raw_name)
    key = normalize_key(raw_name)
    where('LOWER(name) = ?', key).first
  end

  def self.normalize_key(str)
    str.to_s.strip.gsub(/\s+/, ' ').downcase
  end

  def all_games(season = nil)
    scope = Game.where("home_team_id = ? OR away_team_id = ?", id, id)
    season ? scope.where(season: season) : scope
  end

  def for_season(season)
    team_seasons.find_by(season: season)
  end
  
  private

  def normalize_name!
    self.name = self.class.normalize_key(name).split.map(&:capitalize).join(' ') if name.present?
  end

end
