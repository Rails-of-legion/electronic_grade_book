FactoryBot.define do
  factory :attendance do
    date { Time.zone.today }
    attendance_status { 'present' }
    subject { create(:subject) }
    student { create(:student) }
  end
end
