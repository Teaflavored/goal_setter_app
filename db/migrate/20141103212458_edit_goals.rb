class EditGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :type
    add_column :goals, :goal_type, :string
    change_column :goals, :goal_type, :string, null: false
  end
end
