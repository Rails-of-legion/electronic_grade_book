class NotificationsUser < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "notification_id", "updated_at", "user_id"]
  end
end
