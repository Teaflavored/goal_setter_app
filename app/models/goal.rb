# == Schema Information
#
# Table name: goals
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  content        :text             not null
#  goal_setter_id :integer          not null
#  completed      :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  goal_type      :string(255)      not null
#

class Goal < ActiveRecord::Base
  GOAL_TYPES = ["private", "public"]
  validates :name, :content, :goal_type, 
            :goal_setter, :goal_setter_id,
            presence: true
            
  validates :goal_type, inclusion: { in: GOAL_TYPES }
  validates :completed, inclusion: { in: [true, false] }
  
  
  belongs_to(
    :goal_setter,
    class_name: "User",
    foreign_key: :goal_setter_id,
    primary_key: :id
  )
  has_many :comments, as: :commentable
  
  def cheer!
    self.cheer_count += 1
    self.save!
  end
    
end