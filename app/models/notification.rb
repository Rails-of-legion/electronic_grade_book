class Notification < ApplicationRecord
  has_many :notifications_users
  has_many :users, through: :notifications_users

  validates :message, presence: true, length: { maximum: 255 }
  validates :date, presence: true
  validates :read_status, presence: true

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date id id_value message read_status updated_at user_id]
  end
end
