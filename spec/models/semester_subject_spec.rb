require 'rails_helper'

RSpec.describe SemestersSubject, type: :model do
  describe 'associations' do
    it { should belong_to(:semester) }
    it { should belong_to(:subject) }
  end
  describe '.ransackable_attributes' do
    it 'includes expected attributes' do
      expected_attributes = %w[created_at semester_id subject_id updated_at]
      expect(SemestersSubject.ransackable_attributes).to match_array(expected_attributes)
    end
  end
  describe 'validations' do
    it 'is valid with valid attributes' do
      semester = create(:semester) # Убедитесь, что фабрики для этих моделей определены
      subject = create(:subject)
      semesters_subject = SemestersSubject.new(semester: semester, subject: subject)

      expect(semesters_subject).to be_valid
    end

    it 'is not valid without a semester' do
      subject = create(:subject)
      semesters_subject = SemestersSubject.new(subject: subject)

      expect(semesters_subject).not_to be_valid
    end

    it 'is not valid without a subject' do
      semester = create(:semester)
      semesters_subject = SemestersSubject.new(semester: semester)

      expect(semesters_subject).not_to be_valid
    end
  end
end