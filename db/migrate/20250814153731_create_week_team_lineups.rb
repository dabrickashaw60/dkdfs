class CreateWeekTeamLineups < ActiveRecord::Migration[6.1]
  def change
    create_table :week_team_lineups do |t|
      t.references :week, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.text    :lineup_text
      t.decimal :points, precision: 7, scale: 2
      t.timestamps
    end

    add_index :week_team_lineups, [:week_id, :team_id], unique: true
  end
end
