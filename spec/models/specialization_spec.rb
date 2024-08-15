require 'rails_helper'

RSpec.describe Specialization do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  context 'when name is not present' do
    subject { build(:specialization, name: '') }

    it { is_expected.not_to be_valid }

    it 'returns an error message' do
      subject.valid?
      expect(subject.errors[:name]).to include("не может быть пустым")
    end
  end

  context 'when name is not unique' do
    subject { build(:specialization, name: 'Информатика') }

    before { create(:specialization, name: 'Информатика') }

    it { is_expected.not_to be_valid }

    it 'returns an error message' do
      subject.valid?
      expect(subject.errors[:name]).to include('уже существует')
    end
  end

  context 'when name is not unique (case-insensitive)' do
    subject { build(:specialization, name: 'информатика') }

    before { create(:specialization, name: 'Информатика') }

    it { is_expected.not_to be_valid }

    it 'returns an error message' do
      subject.valid?
      expect(subject.errors[:name]).to include('уже существует')
    end
  end
  describe 'associations' do
    it { is_expected.to have_many(:specialities_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:specialities_subjects) }
    it { is_expected.to have_many(:record_books).dependent(:destroy) }
    it { is_expected.to have_many(:groups).dependent(:destroy) }
  end
  describe '.ransackable_attributes' do
    it 'returns correct attributes for ransack' do
      expect(Specialization.ransackable_attributes).to match_array(%w[created_at id id_value name updated_at])
    end
  end

  describe '.ransackable_associations' do
    it 'returns correct associations for ransack' do
      expect(Specialization.ransackable_associations).to match_array([:subjects, :groups, :record_books])
    end
  end
end
