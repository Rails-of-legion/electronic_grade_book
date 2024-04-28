class NotificationsUser < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id notification_id updated_at user_id]
  end
end
