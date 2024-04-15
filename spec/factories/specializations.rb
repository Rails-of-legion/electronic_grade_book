FactoryBot.define do
  factory :specialization do
    name { Faker::Job.field }
  end
end
