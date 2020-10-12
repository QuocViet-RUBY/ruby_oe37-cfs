User.create!(full_name: "Admin",
            email:"admin@gmail.com",
            password: "123456",
            password_confirmation: "123456",
            role: true,
            activated: true,
            activated_at: DateTime.now)

20.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "123456"
  User.create!(full_name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: DateTime.now)
end

users = User.order(:created_at).take(6)
10.times do
  name = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.categories.create!(name: name) }
end

99.times do
  created_at = Faker::Time.between_dates(from: 10.month.ago, to: 20.month.ago, period: :all)
  Plan.create!(
    month: rand(1..12),
    category_id: rand(1..5),
    spending_category: rand(1..2),
    type_money: rand(1..2),
    status: rand(1..2),
    moneys: rand(1000..10000),
    user_id: rand(1..10),
    created_at: created_at
  )
end

99.times do Plan.create!(
  month: rand(1..12),
  category_id: rand(1..5),
  spending_category: rand(0..1),
  type_money: rand(0..1),
  status: rand(0..1),
  moneys: rand(1000..10000),
  user_id: rand(1..10))
end
