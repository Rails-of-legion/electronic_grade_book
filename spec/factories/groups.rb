FactoryBot.define do
  factory :group do
    name { "Group #{Faker::Number.unique.number(digits: 2)}" }
    form_of_education { %w[full_time part_time].sample }
    association :curator, factory: :user
    association :specialization
  end
end