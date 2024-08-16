require 'rails_helper'

RSpec.describe Grade do
  let(:subject) { create(:subject) }
  let(:record_book) { create(:record_book) }

  describe '.ransackable_attributes' do
    it 'includes expected attributes' do
      expect(Grade.ransackable_attributes).to include('created_at', 'date', 'grade', 'id', 'id_value', 'record_book_id', 'subject_id', 'updated_at')
    end
  end

  describe '.ransackable_associations' do
    it 'includes expected associations' do
      expect(Grade.ransackable_associations).to include('record_book', 'subject')
    end
  end
end
