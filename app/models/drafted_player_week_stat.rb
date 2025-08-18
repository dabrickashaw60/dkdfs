class DraftedPlayerWeekStat < ApplicationRecord
  belongs_to :week
  belongs_to :player

  validates :week_id, :player_id, :roster_position, presence: true
  validates :player_id, uniqueness: { scope: :week_id }
end
