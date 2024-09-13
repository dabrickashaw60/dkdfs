class ChangeHighestWeekToBeStringInTeams < ActiveRecord::Migration[7.1]
  def change
    change_column :teams, :highest_week, :string

  end
end
