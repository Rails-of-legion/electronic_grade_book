FactoryBot.define do
    factory :retake do
      association :subject
      association :student
      association :grade
      date { Faker::Date.between(from: '2022-09-23', to: '2024-09-25') }
    end
  end