require 'rails_helper'

RSpec.describe Subject do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:intermediate_attestations) }
    it { is_expected.to have_many(:teachers_subjects) }
    it { is_expected.to have_many(:teachers).through(:teachers_subjects) }
    it { is_expected.to have_many(:semesters).through(:semesters_subjects) }
  end

  describe 'factory' do
    context 'when creating a subject' do
      let(:subject) { create(:subject) }
      let(:semester) { create(:semester) }

      before do
        create(:semesters_subject, subject: subject, semester: semester)
      end

      it 'creates subject with related semester that is of type Semester' do
        expect(subject.semesters).to include(semester)
      end

      it 'creates different semesters for different subjects' do
        subject1 = create(:subject)
        subject2 = create(:subject)
        semester1 = create(:semester)
        semester2 = create(:semester)

        create(:semesters_subject, subject: subject1, semester: semester1)
        create(:semesters_subject, subject: subject2, semester: semester2)

        expect(subject1.semesters).to include(semester1)
        expect(subject2.semesters).to include(semester2)
        expect(subject1.semesters).not_to include(semester2)
        expect(subject2.semesters).not_to include(semester1)
      end
    end
  end
  describe '.ransackable_attributes' do
    it 'returns correct attributes for ransack' do
      expect(Subject.ransackable_attributes).to eq(%w[created_at description id name updated_at])
    end
  end
  describe '.ransackable_associations' do
    it 'returns correct associations for ransack' do
      expect(Subject.ransackable_associations).to eq(%w[
      grades
      intermediate_attestations
      semesters
      semesters_subjects
      specialities_subjects
      specializations
      teachers
      teachers_subjects
    ])
    end
  end
end
