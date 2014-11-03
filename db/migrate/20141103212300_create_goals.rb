class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.string :type, null: false
      t.integer :goal_setter_id, null: false
      t.boolean :completed, default: false
      t.timestamps
    end
    
    add_index :goals, :goal_setter_id
  end
end
