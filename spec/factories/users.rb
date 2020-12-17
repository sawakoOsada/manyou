FactoryBot.define do
  factory :user do
    name { "test_user" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { "test_password" }
    admin { false }
  end
  factory :admin, class: User do
    name { "admin" }
    sequence(:email) { |n| "admin#{n}@test.com" }
    password { "admin_password" }
    admin { true }
  end
end
