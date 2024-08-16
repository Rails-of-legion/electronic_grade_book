require 'rails_helper'

RSpec.describe RecordBook do
  let(:user) { create(:user) }
  let(:intermediate_attestation) { create(:intermediate_attestation) }
  let(:specialization) { create(:specialization) }
  let(:group) { create(:group) }

  let(:record_book) do
    create(:record_book,
           user: user,
           specialization: specialization,
           group: group,
           custom_number: Faker::Number.unique.number(digits: 6).to_s)
  end
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:specialization) }
    it { should belong_to(:group) }
    it { should have_many(:grades).dependent(:destroy) }
  end
  describe 'validations' do
    it { should validate_presence_of(:custom_number) }
  end
  describe '.ransackable_associations' do
    it 'returns a list of associations' do
      expect(described_class.ransackable_associations).to match_array(%w[grades intermediate_attestation user group specialization])
    end
  end
  describe '.ransackable_attributes' do
    it 'returns a list of attributes' do
      expect(described_class.ransackable_attributes).to match_array(%w[created_at user_id id intermediate_attestation_id updated_at custom_number retake_count])
    end
  end
end
