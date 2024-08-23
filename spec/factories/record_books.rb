FactoryBot.define do
  factory :record_book do
    user { association :user, :as_student }
    specialization { association :specialization }
    group { association :group }
    custom_number { "RB#{SecureRandom.hex(4)}" } 
  end
end
