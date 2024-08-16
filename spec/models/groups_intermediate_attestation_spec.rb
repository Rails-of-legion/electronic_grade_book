require 'rails_helper'

RSpec.describe GroupsIntermediateAttestation, type: :model do
  describe 'associations' do
    it { should belong_to(:group) }
    it { should belong_to(:intermediate_attestation) }
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(GroupsIntermediateAttestation.ransackable_attributes).to match_array(
        %w[created_at group_id id id_value intermediate_attestation_id updated_at]
      )
    end
  end
end
