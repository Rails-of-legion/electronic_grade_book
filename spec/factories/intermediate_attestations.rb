# spec/factories/intermediate_attestations.rb
FactoryBot.define do
  factory :intermediate_attestation do
    association :subject
    association :teacher, factory: :user
    name { Faker::Lorem.sentence }
    date { Faker::Date.between(from: 2.years.ago, to: Time.zone.today) }
    assessment_type { Faker::Lorem.word }
  end
end
