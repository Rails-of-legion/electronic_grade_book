FactoryBot.define do
  factory :semester do
    name { Faker::Lorem.word }
    start_date { Faker::Time.between(from: 2.years.ago, to: Time.zone.today) }
    end_date { Faker::Time.between(from: start_date, to: Time.zone.today) }
  end
end
