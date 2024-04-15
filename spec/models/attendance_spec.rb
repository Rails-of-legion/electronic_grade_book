require 'rails_helper'

RSpec.describe Attendance do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:attendance_status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:subject) }
    it { is_expected.to belong_to(:student) }
  end
end
