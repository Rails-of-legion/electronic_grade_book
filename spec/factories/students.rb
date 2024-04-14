FactoryBot.define do
  factory :student do
    association :user, strategy: :build
    association :specialization, strategy: :build
    association :group, strategy: :build
  end
end
