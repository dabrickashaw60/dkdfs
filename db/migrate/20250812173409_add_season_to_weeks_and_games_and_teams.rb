class AddSeasonToWeeksAndGamesAndTeams < ActiveRecord::Migration[6.1]
  def change
  add_column :weeks, :season, :string
  add_column :games, :season, :string
  add_column :teams, :season, :string
  end
end
