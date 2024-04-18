class Notification < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: { maximum: 255 }
  validates :date, presence: true
  validates :read_status, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "id_value", "message", "read_status", "updated_at", "user_id"]
  end

end
