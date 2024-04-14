FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    association :curator, factory: :user
  end
end

