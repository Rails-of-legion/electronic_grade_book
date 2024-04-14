require 'rails_helper'

RSpec.describe Semester do
  describe 'validations' do
    subject { build(:semester) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:subjects) }
  end
end
