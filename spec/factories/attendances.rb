FactoryBot.define do
  factory :attendance do
    subject_id { 1 }
    student_id { 1 }
    date { "2024-04-14" }
    attendance_status { "MyString" }
  end
end
