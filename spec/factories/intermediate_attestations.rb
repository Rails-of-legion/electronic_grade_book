FactoryBot.define do
  factory :intermediate_attestation do
    subject { create(:subject) }
    name { Faker::Lorem.sentence }
    date { Faker::Date.between(from: 2.years.ago, to: Time.zone.today) }
    assessment_type { Faker::Lorem.word }
    # Убедитесь, что этот атрибут существует, иначе удалите строку ниже
    # max_grade { Faker::Number.between(from: 1, to: 10) }
  end
end
