FactoryBot.define do
  factory :user do
    name { "common_user" }
    sequence(:email) { "user@test.com" }
    password { "user_password" }
    admin { false }
  end
  factory :admin, class: User do
    name { "admin_user" }
    sequence(:email) { "admin@test.com" }
    password { "admin_password" }
    admin { true }
  end
end
