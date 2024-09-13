class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :week, null: false, foreign_key: true
      t.references :home_team, null: false, foreign_key: { to_table: :teams }
      t.references :away_team, null: false, foreign_key: { to_table: :teams }
      t.decimal :home_score, precision: 8, scale: 2
      t.decimal :away_score, precision: 8, scale: 2

      t.timestamps
    end
  end
end
