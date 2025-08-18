# frozen_string_literal: true
class EnsureTeamSeason
  def self.call(team_name:, season:)
    normalized = Team.normalize_key(team_name)
    team = Team.find_ci_by_name(normalized) || Team.create!(name: team_name)

    ts = TeamSeason.find_or_create_by!(team: team, season: season)
    [team, ts]
  end
end
