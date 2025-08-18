class CreateDraftedPlayerWeekStats < ActiveRecord::Migration[6.1]
  def change
    create_table :drafted_player_week_stats do |t|
      t.references :week, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string  :roster_position, null: false
      t.decimal :pct_drafted, precision: 5, scale: 2
      t.decimal :fpts, precision: 7, scale: 2
      t.timestamps
    end

    add_index :drafted_player_week_stats, [:week_id, :player_id], unique: true
  end
end
