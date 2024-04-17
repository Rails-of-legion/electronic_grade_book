# spec/models/notification_spec.rb

require 'rails_helper'

RSpec.describe Notification do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_length_of(:message).is_at_most(255) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:read_status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'factory' do
    it 'is valid' do
      notification = create(:notification)
      expect(notification).to be_valid
    end
  end
end
