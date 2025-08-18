class WeekTeamLineup < ApplicationRecord
  belongs_to :week
  belongs_to :team

  validates :team_id, uniqueness: { scope: :week_id }

  POSITION_TOKENS = %w[QB RB WR TE FLEX DST].freeze
  DISPLAY_ORDER   = %w[QB RB RB WR WR WR TE FLEX DST].freeze

  # Returns a hash of arrays: { "QB"=>["Jayden Daniels"], "RB"=>["James Cook","Kenneth Walker III"], ... }
  def parsed_lineup
    return {} if lineup_text.blank?

    tokens  = lineup_text.split(/\s+/)
    result  = POSITION_TOKENS.map { |p| [p, []] }.to_h
    current = nil
    buffer  = []

    tokens.each do |tok|
      up = tok.upcase
      if POSITION_TOKENS.include?(up)
        # flush previous buffer into its position
        if current
          name = buffer.join(" ").strip
          result[current] << name unless name.blank?
        end
        current = up
        buffer  = []
      else
        buffer << tok
      end
    end

    # flush tail
    if current
      name = buffer.join(" ").strip
      result[current] << name unless name.blank?
    end

    result
  end

  # Returns an ordered array of [slot, name] in DraftKings order.
  # Example: [["QB","Jayden Daniels"], ["RB","James Cook"], ["RB","Kenneth Walker III"], ...]
  def normalized_lineup
    p = parsed_lineup

    out = []
    rb_list = p["RB"].dup
    wr_list = p["WR"].dup

    DISPLAY_ORDER.each do |slot|
      case slot
      when "QB"  then out << ["QB",   p["QB"].first]
      when "RB"  then out << ["RB",   rb_list.shift]
      when "WR"  then out << ["WR",   wr_list.shift]
      when "TE"  then out << ["TE",   p["TE"].first]
      when "FLEX" then out << ["FLEX", p["FLEX"].first]
      when "DST"  then out << ["DST",  p["DST"].first]
      end
    end

    # compact nils in case the CSV was missing something
    out.map { |slot, name| [slot, name.to_s.presence] }.reject { |_, name| name.blank? }
  end
end
