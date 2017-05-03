FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testuser#{n}@test.com" }
    sequence(:username) { |n| "testuser#{n}" }
    password 'password'
    password_confirmation 'password'
    role 'member'
  end
end
