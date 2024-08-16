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
    let(:date) { Date.today }
  
    it 'returns correct records for date_gteq' do
      subject = create(:subject)  # Создайте необходимые ассоциации
      teacher = create(:user)     # Создайте необходимые ассоциации
      attestation = create(:intermediate_attestation, date: date, subject: subject, teacher: teacher)
      expect(IntermediateAttestation.ransack(date_gteq: date).result).to include(attestation)
    end
  
    it 'returns correct records for date_lteq' do
      subject = create(:subject)  # Создайте необходимые ассоциации
      teacher = create(:user)     # Создайте необходимые ассоциации
      attestation = create(:intermediate_attestation, date: date, subject: subject, teacher: teacher)
      expect(IntermediateAttestation.ransack(date_lteq: date).result).to include(attestation)
    end
  end  
end
