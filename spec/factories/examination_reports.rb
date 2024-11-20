FactoryBot.define do
  factory :examination_report do
    group { "MyString" }
    subject { "MyString" }
    attestation { "MyString" }
    teacher { "MyString" }
    student { "MyString" }
    date_of_statement { "2024-11-06" }
    date_until_valid { "2024-11-06" }
    mark { 1 }
    date_of_attestation { "2024-11-06" }
  end
end
