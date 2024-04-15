FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    curator factory: %i[user]
  end
end
