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

FactoryGirl.define do
  factory :goal do
    name { Faker::Lorem.word }
    content { Faker::Hacker.say_something_smart }
    goal_setter
    goal_type "public"
  end

  factory :private_goal, class: Goal do
    name { Faker::Lorem.word }
    content { Faker::Hacker.say_something_smart }
    goal_setter
    goal_type "private"
  end
end
