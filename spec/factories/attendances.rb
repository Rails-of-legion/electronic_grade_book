FactoryBot.define do
  factory :attendance do
    date { Time.zone.today }
    attendance_status { 'present' }
    subject { create(:subject) }
    record_book { create(:record_book) }
  end
end
