class CreateTeamSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :team_seasons do |t|
      t.references :team, null: false, foreign_key: true
      t.string :season
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.float :points_for
      t.float :points_against
      t.string :highest_week
      t.float :dollars_owed
      t.float :dollars_won

      t.timestamps
    end
  end
end
