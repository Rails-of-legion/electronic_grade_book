require 'rails_helper'

RSpec.describe SpecialitiesSubject do
  let(:specialization) { create(:specialization) }
  let(:subject) { create(:subject) }

  describe '.ransackable_attributes' do
    it 'includes expected attributes' do
      expected_attributes = %w[created_at id id_value specialization_id subject_id updated_at]
      expect(SpecialitiesSubject.ransackable_attributes).to match_array(expected_attributes)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      specialities_subject = SpecialitiesSubject.new(specialization: specialization, subject: subject)
      expect(specialities_subject).to be_valid
    end
  end
end
