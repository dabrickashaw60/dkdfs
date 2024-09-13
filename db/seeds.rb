# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Team.create([
  { name: "BELLAMICKPRUNESSPOT1", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "bigbearx40", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "dabrickashaw24", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "HAHNY0L0", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "hoodiesq", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "Jk3325", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "johnphil82", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "Joseph17carter", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "jvanalstyne", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "ksteves", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "nyramman", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "TayDigs", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "TomZaffino", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 },
  { name: "vivduh", dollars_owed: 200, dollars_won: 0, wins: 0, losses: 0, ties: 0, points_for: 0, points_against: 0, highest_week: 0 }
])

# Create teams
teams = {
  'nyramman' => Team.find_or_create_by!(name: 'nyramman'),
  'BELLAMICKPRUNESSPOT1' => Team.find_or_create_by!(name: 'BELLAMICKPRUNESSPOT1'),
  'Joseph17carter' => Team.find_or_create_by!(name: 'Joseph17carter'),
  'vivduh' => Team.find_or_create_by!(name: 'vivduh'),
  'johnphil82' => Team.find_or_create_by!(name: 'johnphil82'),
  'HAHNY0L0' => Team.find_or_create_by!(name: 'HAHNY0L0'),
  'dabrickashaw24' => Team.find_or_create_by!(name: 'dabrickashaw24'),
  'hoodiesq' => Team.find_or_create_by!(name: 'hoodiesq'),
  'ksteves' => Team.find_or_create_by!(name: 'ksteves'),
  'Jk3325' => Team.find_or_create_by!(name: 'Jk3325'),
  'jvanalstyne' => Team.find_or_create_by!(name: 'jvanalstyne'),
  'TayDigs' => Team.find_or_create_by!(name: 'TayDigs'),
  'bigbearx40' => Team.find_or_create_by!(name: 'bigbearx40'),
  'TomZaffino' => Team.find_or_create_by!(name: 'TomZaffino')
}

# Helper method to create games
def create_game(week, home_team, away_team)
  Game.create!(
    week: week,
    home_team: home_team,
    away_team: away_team,
    home_score: 0,
    away_score: 0
  )
end

# Create weeks and games
(1..14).each do |week_number|
  week = Week.create!(number: week_number)

  case week_number
  when 1
    create_game(week, teams['nyramman'], teams['BELLAMICKPRUNESSPOT1'])
    create_game(week, teams['Joseph17carter'], teams['vivduh'])
    create_game(week, teams['johnphil82'], teams['HAHNY0L0'])
    create_game(week, teams['dabrickashaw24'], teams['hoodiesq'])
    create_game(week, teams['ksteves'], teams['Jk3325'])
    create_game(week, teams['jvanalstyne'], teams['TayDigs'])
    create_game(week, teams['bigbearx40'], teams['TomZaffino'])
  when 2
    create_game(week, teams['nyramman'], teams['Joseph17carter'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['TomZaffino'])
    create_game(week, teams['johnphil82'], teams['vivduh'])
    create_game(week, teams['dabrickashaw24'], teams['HAHNY0L0'])
    create_game(week, teams['ksteves'], teams['hoodiesq'])
    create_game(week, teams['jvanalstyne'], teams['Jk3325'])
    create_game(week, teams['bigbearx40'], teams['TayDigs'])
  when 3
    create_game(week, teams['nyramman'], teams['johnphil82'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['Joseph17carter'])
    create_game(week, teams['dabrickashaw24'], teams['vivduh'])
    create_game(week, teams['ksteves'], teams['HAHNY0L0'])
    create_game(week, teams['jvanalstyne'], teams['hoodiesq'])
    create_game(week, teams['bigbearx40'], teams['Jk3325'])
    create_game(week, teams['TayDigs'], teams['TomZaffino'])
  when 4
    create_game(week, teams['nyramman'], teams['dabrickashaw24'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['johnphil82'])
    create_game(week, teams['Joseph17carter'], teams['TomZaffino'])
    create_game(week, teams['ksteves'], teams['vivduh'])
    create_game(week, teams['jvanalstyne'], teams['HAHNY0L0'])
    create_game(week, teams['bigbearx40'], teams['hoodiesq'])
    create_game(week, teams['TayDigs'], teams['Jk3325'])
  when 5
    create_game(week, teams['nyramman'], teams['ksteves'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['dabrickashaw24'])
    create_game(week, teams['Joseph17carter'], teams['johnphil82'])
    create_game(week, teams['jvanalstyne'], teams['vivduh'])
    create_game(week, teams['bigbearx40'], teams['HAHNY0L0'])
    create_game(week, teams['TayDigs'], teams['hoodiesq'])
    create_game(week, teams['Jk3325'], teams['TomZaffino'])
  when 6
    create_game(week, teams['nyramman'], teams['jvanalstyne'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['ksteves'])
    create_game(week, teams['Joseph17carter'], teams['dabrickashaw24'])
    create_game(week, teams['johnphil82'], teams['TomZaffino'])
    create_game(week, teams['bigbearx40'], teams['vivduh'])
    create_game(week, teams['TayDigs'], teams['HAHNY0L0'])
    create_game(week, teams['Jk3325'], teams['hoodiesq'])
  when 7
    create_game(week, teams['nyramman'], teams['bigbearx40'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['jvanalstyne'])
    create_game(week, teams['Joseph17carter'], teams['ksteves'])
    create_game(week, teams['johnphil82'], teams['dabrickashaw24'])
    create_game(week, teams['TayDigs'], teams['vivduh'])
    create_game(week, teams['Jk3325'], teams['HAHNY0L0'])
    create_game(week, teams['hoodiesq'], teams['TomZaffino'])
  when 8
    create_game(week, teams['nyramman'], teams['TayDigs'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['bigbearx40'])
    create_game(week, teams['Joseph17carter'], teams['jvanalstyne'])
    create_game(week, teams['johnphil82'], teams['ksteves'])
    create_game(week, teams['dabrickashaw24'], teams['TomZaffino'])
    create_game(week, teams['Jk3325'], teams['vivduh'])
    create_game(week, teams['hoodiesq'], teams['HAHNY0L0'])
  when 9
    create_game(week, teams['nyramman'], teams['Jk3325'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['TayDigs'])
    create_game(week, teams['Joseph17carter'], teams['bigbearx40'])
    create_game(week, teams['johnphil82'], teams['jvanalstyne'])
    create_game(week, teams['dabrickashaw24'], teams['ksteves'])
    create_game(week, teams['hoodiesq'], teams['vivduh'])
    create_game(week, teams['HAHNY0L0'], teams['TomZaffino'])
  when 10
    create_game(week, teams['nyramman'], teams['hoodiesq'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['Jk3325'])
    create_game(week, teams['Joseph17carter'], teams['TayDigs'])
    create_game(week, teams['johnphil82'], teams['bigbearx40'])
    create_game(week, teams['dabrickashaw24'], teams['jvanalstyne'])
    create_game(week, teams['ksteves'], teams['TomZaffino'])
    create_game(week, teams['HAHNY0L0'], teams['vivduh'])
  when 11
    create_game(week, teams['nyramman'], teams['HAHNY0L0'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['hoodiesq'])
    create_game(week, teams['Joseph17carter'], teams['Jk3325'])
    create_game(week, teams['johnphil82'], teams['TayDigs'])
    create_game(week, teams['dabrickashaw24'], teams['bigbearx40'])
    create_game(week, teams['ksteves'], teams['jvanalstyne'])
    create_game(week, teams['vivduh'], teams['TomZaffino'])
  when 12
    create_game(week, teams['nyramman'], teams['vivduh'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['HAHNY0L0'])
    create_game(week, teams['Joseph17carter'], teams['hoodiesq'])
    create_game(week, teams['johnphil82'], teams['Jk3325'])
    create_game(week, teams['dabrickashaw24'], teams['TayDigs'])
    create_game(week, teams['ksteves'], teams['bigbearx40'])
    create_game(week, teams['jvanalstyne'], teams['TomZaffino'])
  when 13
    create_game(week, teams['nyramman'], teams['TomZaffino'])
    create_game(week, teams['BELLAMICKPRUNESSPOT1'], teams['vivduh'])
    create_game(week, teams['Joseph17carter'], teams['HAHNY0L0'])
    create_game(week, teams['johnphil82'], teams['hoodiesq'])
    create_game(week, teams['dabrickashaw24'], teams['Jk3325'])
    create_game(week, teams['ksteves'], teams['TayDigs'])
    create_game(week, teams['jvanalstyne'], teams['bigbearx40'])
  when 14
    create_game(week, teams['nyramman'], teams['BELLAMICKPRUNESSPOT1'])
    create_game(week, teams['Joseph17carter'], teams['vivduh'])
    create_game(week, teams['johnphil82'], teams['HAHNY0L0'])
    create_game(week, teams['dabrickashaw24'], teams['hoodiesq'])
    create_game(week, teams['ksteves'], teams['Jk3325'])
    create_game(week, teams['jvanalstyne'], teams['TayDigs'])
    create_game(week, teams['bigbearx40'], teams['TomZaffino'])
  end
end

puts "Weeks and games have been seeded successfully!"
