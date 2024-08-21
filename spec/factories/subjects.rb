FactoryBot.define do
  factory :subject do
    name { "Subject #{SecureRandom.hex(3)}" }
    description { Faker::Lorem.paragraph }
  end
end
