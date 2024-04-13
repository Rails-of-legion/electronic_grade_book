require 'rails_helper'

RSpec.describe Specialization do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  context 'when name is not present' do
    subject { build(:specialization, name: '') }

    it { is_expected.not_to be_valid }

    it 'returns an error message' do
      subject.valid?
      expect(subject.errors[:name]).to include("can't be blank")
    end
  end

  context 'when name is not unique' do
    subject { build(:specialization, name: 'Информатика') }

    before { create(:specialization, name: 'Информатика') }

    it { is_expected.not_to be_valid }

    it 'returns an error message' do
      subject.valid?
      expect(subject.errors[:name]).to include('has already been taken')
    end
  end

  context 'when name is not unique (case-insensitive)' do
    subject { build(:specialization, name: 'информатика') }

    before { create(:specialization, name: 'Информатика') }

    it { is_expected.not_to be_valid }

    it 'returns an error message' do
      subject.valid?
      expect(subject.errors[:name]).to include('has already been taken')
    end
  end
end
