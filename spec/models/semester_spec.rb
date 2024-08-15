require 'rails_helper'

RSpec.describe Semester do
  describe 'validations' do
    subject { build(:semester) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it 'is valid with valid attributes' do
      semester = build(:semester)
      expect(semester).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:semesters_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:semesters_subjects).dependent(:destroy) }
  end

  describe '.ransackable_attributes' do
    it 'returns correct attributes for ransack' do
      expect(Semester.ransackable_attributes).to eq(%w[created_at end_date id id_value name start_date updated_at])
    end
  end
end
