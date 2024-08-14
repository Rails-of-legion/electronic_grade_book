FactoryBot.define do
  factory :subject do
    name { Faker::Educator.subject }
    description { Faker::Lorem.paragraph }
  end
end
