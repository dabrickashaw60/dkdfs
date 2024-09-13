class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.decimal :dollars_owed, precision: 8, scale: 2
      t.decimal :dollars_won, precision: 8, scale: 2
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.decimal :points_for, precision: 8, scale: 2
      t.decimal :points_against, precision: 8, scale: 2
      t.decimal :highest_week, precision: 8, scale: 2

      t.timestamps
    end
  end
end
