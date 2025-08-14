class AddSeasonToWeeksAndGames < ActiveRecord::Migration[6.1]
  def change
    add_column :weeks, :season, :string unless column_exists?(:weeks, :season)
    add_column :games, :season, :string unless column_exists?(:games, :season)
  end
end
