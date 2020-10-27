require "faker"

FactoryBot.define do
  factory :category do
    name {Faker::Lorem.sentence(word_count: 5)}
    delete_flag {0}
    association :user
  end
end
