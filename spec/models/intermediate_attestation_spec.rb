require 'rails_helper'

RSpec.describe IntermediateAttestation, type: :model do
  it { should belong_to(:subject).required }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:assessment_type) }
  it { should validate_presence_of(:max_grade) }
  it { should validate_numericality_of(:max_grade) }

  describe 'max_grade validation' do
    let(:attestation) { build(:intermediate_attestation) }

    it 'is invalid with max_grade greater than 10' do
      attestation.max_grade = 11
      expect(attestation).to_not be_valid
      expect(attestation.errors[:max_grade]).to include("must be less than or equal to 10")
    end

    it 'is valid with max_grade less than or equal to 10' do
      attestation.max_grade = 10
      expect(attestation).to be_valid
    end
  end

  describe 'subject association' do
    it 'is invalid without a subject' do
      attestation = build(:intermediate_attestation, subject: nil)
      expect(attestation).to_not be_valid
      expect(attestation.errors[:subject]).to include("must exist")
    end
  end
end