FactoryBot.define do
  factory :notification do
    user
    message { Faker::Lorem.sentence }
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    read_status { Faker::Lorem.sentence }
  end
end
