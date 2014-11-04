class AddCheersToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :cheer_count, :integer, default: 0
  end
end
