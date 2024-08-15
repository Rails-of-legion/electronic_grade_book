# spec/models/notification_spec.rb
require 'rails_helper'

RSpec.describe Notification, type: :model do
  # Проверка валидностей
  it { should validate_presence_of(:message) }
  it { should validate_length_of(:message).is_at_most(255) }
  it { should validate_presence_of(:date) }
  it { should have_many(:notifications_users).dependent(:destroy) }
  it { should have_many(:users).through(:notifications_users) }

  # Проверка создания записи
  it "is valid with valid attributes" do
    notification = build(:notification)
    notification.users << create(:user)
    expect(notification).to be_valid
  end
  
  it "is not valid without a message" do
    notification = build(:notification, message: nil)
    expect(notification).not_to be_valid
  end

  it "is not valid without a date" do
    notification = build(:notification, date: nil)
    expect(notification).not_to be_valid
  end

  it "is not valid without users" do
    notification = build(:notification)
    notification.users.clear
    expect(notification).not_to be_valid
  end

  # Проверка ассоциаций
  describe 'associations' do
    it 'has many users through notifications_users' do
      should have_many(:users).through(:notifications_users)
    end
  end

  # Проверка self.ransackable_associations и self.ransackable_attributes
  describe '.ransackable_associations' do
    it 'includes notifications_users and users' do
      expect(Notification.ransackable_associations).to include('notifications_users', 'users')
    end
  end

  describe '.ransackable_attributes' do
    it 'includes expected attributes' do
      expect(Notification.ransackable_attributes).to include('created_at', 'date', 'id', 'id_value', 'message', 'status', 'updated_at', 'user_id')
    end
  end
end