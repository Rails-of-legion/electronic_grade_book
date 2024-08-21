FactoryBot.define do
  factory :group do
    name { "Unique Group #{SecureRandom.hex(5)}" } # Генерация уникального имени группы
    form_of_education { %w[full_time part_time].sample }
    association :curator, factory: :user
    association :specialization
  end
end
