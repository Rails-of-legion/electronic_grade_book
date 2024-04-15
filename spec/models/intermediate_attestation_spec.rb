require 'rails_helper'

RSpec.describe IntermediateAttestation do
  describe 'validations' do
    it { is_expected.to belong_to(:subject).required }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:assessment_type) }
    it { is_expected.to validate_presence_of(:max_grade) }
    it { is_expected.to validate_numericality_of(:max_grade) }
    it { is_expected.to have_many(:record_books) }
  end

  describe 'max_grade validation' do
    let(:attestation) { build(:intermediate_attestation) }

    it 'is invalid with max_grade greater than 10' do
      attestation.max_grade = 11
      expect(attestation).not_to be_valid
      expect(attestation.errors[:max_grade]).to include('must be less than or equal to 10')
    end

    it 'is valid with max_grade less than or equal to 10' do
      attestation.max_grade = 10
      expect(attestation).to be_valid
    end
  end

  describe 'subject association' do
    it 'is invalid without a subject' do
      attestation = build(:intermediate_attestation, subject: nil)
      expect(attestation).not_to be_valid
      expect(attestation.errors[:subject]).to include('must exist')
    end
  end
end
