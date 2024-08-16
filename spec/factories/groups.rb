FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    curator factory: %i[user]
    specialization { create(:specialization) }
    form_of_education {'Очная'}
  end
end
