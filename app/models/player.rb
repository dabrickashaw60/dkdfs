class Player < ApplicationRecord
  has_many :drafted_player_week_stats, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :normalize_name

  private

  def normalize_name
    self.name = name.to_s.strip.gsub(/\s+/, ' ')
  end
end
