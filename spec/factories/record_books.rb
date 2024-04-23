FactoryBot.define do
  factory :record_book do
    trait :with_associations do
      subject { association :subject }
      teacher { association :user, :as_teacher }
      intermediate_attestation { association :intermediate_attestation }
    end
  end
end
