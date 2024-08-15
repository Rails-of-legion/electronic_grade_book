FactoryBot.define do
  factory :record_book do
    # Если у RecordBook есть связь с user через поле student_id
    student { association :user, :as_student }
    teacher { association :user, :as_teacher }
    intermediate_attestation { association :intermediate_attestation }

    trait :with_associations do
      subject { association :subject }
      group { association :group } # если RecordBook связан с Group
      specialization { association :specialization } # если RecordBook связан со Specialization
      # Дополнительные поля, если они нужны
    end
  end
end
