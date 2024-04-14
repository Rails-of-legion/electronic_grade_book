FactoryBot.define do
  factory :intermediate_attestation do
    subject { build(:subject) }
    name { Faker::Lorem.sentence }
    date { Faker::Date.between(from: 2.years.ago, to: Time.zone.today) }
    max_grade { Faker::Number.between(from: 1, to: 10) }
    assessment_type { Faker::Lorem.word }
  end
end
