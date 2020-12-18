FactoryBot.define do
  factory :user do
    name { "admined_user" }
    sequence(:email) { "admined@test.com" }
    password { "admined_password" }
    admin { false }
  end
  factory :admin, class: User do
    name { "admin_user" }
    sequence(:email) { "admin@test.com" }
    password { "admin_password" }
    admin { true }
  end
end
