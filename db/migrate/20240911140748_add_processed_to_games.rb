class AddProcessedToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :processed, :boolean
  end
end
