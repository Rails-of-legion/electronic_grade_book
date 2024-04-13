require 'rails_helper'

RSpec.describe Subject do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:assessment_type) }
    it { is_expected.to belong_to(:semester) }
  end

  describe 'Factory' do
    context 'when creating a subject' do
      let(:subject) { create(:subject) } 

      it 'creates subject with related semester that is of type Semester' do
        expect(subject.semester).to be_a(Semester)
      end

      it 'creates subject with related semester that is persisted' do
        expect(subject.semester).to be_persisted
      end

      it 'creates different semesters for different subjects' do
        subject1 = create(:subject)
        subject2 = create(:subject)
        expect(subject1.semester).not_to eq(subject2.semester)
      end
    end
  end
end
