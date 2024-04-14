FactoryBot.define do
  factory :subject do
    name { Faker::Educator.subject }
    description { Faker::Lorem.paragraph }
    assessment_type { Faker::Educator.course_name }
    association :semester, strategy: :build
  end
end
