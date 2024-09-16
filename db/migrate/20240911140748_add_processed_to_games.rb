class AddProcessedToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :processed, :boolean
  end
end
