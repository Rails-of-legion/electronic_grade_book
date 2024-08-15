require 'rails_helper'

RSpec.describe NotificationsUser, type: :model do
  # Проверка ассоциаций
  it { should belong_to(:notification) }
  it { should belong_to(:user) }

  # Проверка методов класса
  describe '.ransackable_attributes' do
    it 'returns the correct attributes' do
      expect(NotificationsUser.ransackable_attributes).to eq(%w[created_at id notification_id updated_at user_id])
    end
  end
end
