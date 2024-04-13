FactoryBot.define do
  factory :semester do
    name { Faker::Lorem.word }
    start_date { Faker::Time.between(2.years.ago, Time.zone.today) }
    end_date { Faker::Time.between(start_date, Time.zone.today) }
  end
end
