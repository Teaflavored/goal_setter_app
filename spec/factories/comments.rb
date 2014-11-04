FactoryGirl.define do
  factory :user_comment, class: Comment do
    content { Faker::Hacker.say_something_smart }
    sequence :commentable do
      FactoryGirl.create(:user)
    end
    author
  end
  
  factory :goal_comment, class: Comment do
    content { Faker::Hacker.say_something_smart }
    sequence :commentable do
      FactoryGirl.create(:goal)
    end
    author
  end

end