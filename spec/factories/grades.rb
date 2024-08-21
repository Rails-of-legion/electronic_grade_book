FactoryBot.define do
  factory :grade do
    record_book { association :record_book }
    subject { association :subject }  # Добавлено обязательное поле
    grade { rand(1..10) }
  end
end
