FactoryBot.define do
  factory :user do
    name { "test_user" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { "test_password" }
  end
  factory :admin do
    name { "admin" }
    sequence(:email) { |n| "admin#{n}@test.com" }
    password { "admin_password" }
  end
end
