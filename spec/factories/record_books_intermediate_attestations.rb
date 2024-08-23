FactoryBot.define do
  factory :record_books_intermediate_attestation do
    association :record_book
    association :intermediate_attestation
  end
end
