FactoryGirl.define do
  factory :comment do
    author
    
    body { Faker::Hacker.say_something_smart }
  end
end