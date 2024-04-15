FactoryBot.define do
  factory :grade do
    record_book { association :record_book }
    grade { rand(1..10) }
  end
end
