FactoryBot.define do
  factory :record_book do
    user { association :user, :as_student }
    teacher { association :user, :as_teacher }
    intermediate_attestation { association :intermediate_attestation }
    specialization { association :specialization }
    group { association :group }
    custom_number { "RB#{SecureRandom.hex(4)}" }  # Генерация уникального номера для каждой записи

    
  end
end
