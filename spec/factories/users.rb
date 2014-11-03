FactoryGirl.define do
  factory :user do
    username do
      Faker::Internet.user_name
    end
    password do
      Faker::Internet.password(8)
    end
  end
end