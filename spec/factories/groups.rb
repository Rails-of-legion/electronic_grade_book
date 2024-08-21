FactoryBot.define do
  factory :group do
    name { "Group #{SecureRandom.hex(3)}" }  # Генерация уникального имени группы
    form_of_education { %w[full_time part_time].sample }
    association :curator, factory: :user
    association :specialization
  end
end
