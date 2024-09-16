class ChangeHighestWeekToBeStringInTeams < ActiveRecord::Migration[6.1]
  def change
    change_column :teams, :highest_week, :string

  end
end
