module WeeksHelper
  def normalize_name(name)
    name.to_s.strip.gsub(/\s+/, ' ')
  end

  # Try exact match, then a couple DST-friendly fallbacks
  def stat_for_lineup_name(name, stats_by_name)
    key = normalize_name(name)
    stat = stats_by_name[key]
    return stat if stat

    # DST heuristics (common CSV variants)
    dst_variants = [
      "#{key} DST",
      "#{key} D/ST",
      key.sub(/\s+DST\z/i, ''),
      key.sub(/\s+D\/ST\z/i, '')
    ]
    dst_variants.each do |alt|
      s = stats_by_name[normalize_name(alt)]
      return s if s
    end

    nil
  end

  def format_pct(val)
    return "" if val.nil?
    "#{val.round(2)}%"
  end

  def format_fpts(val)
    return "" if val.nil?
    val.round(2)
  end
end
