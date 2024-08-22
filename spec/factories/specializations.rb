FactoryBot.define do
  factory :specialization do
    sequence(:name) { |n| "#{Faker::Educator.subject} #{n}" }
  end
end