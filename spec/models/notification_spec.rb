require 'rails_helper'

RSpec.describe Notification, type: :model do
  # Проверка ассоциаций
  it { should have_many(:notifications_users).dependent(:destroy) }
  it { should have_many(:users).through(:notifications_users) }

  # Проверка валидаций
  it { should validate_presence_of(:message) }
  it { should validate_length_of(:message).is_at_most(255) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:users) }

  # Проверка методов класса
  describe '.ransackable_associations' do
    it 'returns the correct associations' do
      expect(Notification.ransackable_associations).to eq(%w[notifications_users users])
    end
  end

  describe '.ransackable_attributes' do
    it 'returns the correct attributes' do
      expect(Notification.ransackable_attributes).to eq(%w[created_at date id id_value message status updated_at user_id])
    end
  end
end
