FactoryBot.define do
  factory :semesters_subject do
    association :subject
    association :semester
  end
end
