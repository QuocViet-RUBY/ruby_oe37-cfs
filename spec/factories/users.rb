require "faker"

FactoryBot.define do
  factory :user do
    full_name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
    trait :user do
      role {User.roles[:user]}
    end
    trait :admin do
      role {User.roles[:admin]}
    end
    activated {:true}
    activated_at {DateTime.now}
  end
end
