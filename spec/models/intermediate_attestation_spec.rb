# spec/models/intermediate_attestation_spec.rb
require 'rails_helper'

RSpec.describe IntermediateAttestation, type: :model do
  describe 'associations' do
    it { should belong_to(:subject) }
    it { should belong_to(:teacher).class_name('User') }
    it { should have_many(:groups_intermediate_attestations).dependent(:destroy) }
    it { should have_many(:groups).through(:groups_intermediate_attestations).dependent(:destroy) }
    it { should have_many(:grades).with_foreign_key(:subject_id) }
    it { should have_many(:record_books) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:assessment_type) }
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(IntermediateAttestation.ransackable_attributes).to match_array(
        %w[assessment_type created_at id id_value name subject_id teacher_id updated_at group_id intermediate_attestation_id]
      )
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of ransackable associations' do
      expect(IntermediateAttestation.ransackable_associations).to match_array(
        %w[groups groups_intermediate_attestations subject teacher]
      )
    end
  end

  describe 'ransackers' do
    let!(:attestation1) { create(:intermediate_attestation, date: 1.month.ago) }
    let!(:attestation2) { create(:intermediate_attestation, date: 1.week.ago) }
    let!(:attestation3) { create(:intermediate_attestation, date: 1.day.ago) }
    
    describe 'date_gteq' do
      it 'returns records with date greater than or equal to the specified date' do
        result = IntermediateAttestation.ransack(date_gteq: 2.weeks.ago.to_date).result
        expect(result).to include(attestation2)
        expect(result).to include(attestation3)
        expect(result).not_to include(attestation1)
      end
    end

    describe 'date_lteq' do
      it 'returns records with date less than or equal to the specified date' do
        result = IntermediateAttestation.ransack(date_lteq: 1.week.ago.to_date).result
        expect(result).to include(attestation1)
        expect(result).to include(attestation2)
        expect(result).not_to include(attestation3)
      end
    end
  end  
end
