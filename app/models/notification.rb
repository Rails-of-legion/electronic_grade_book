class Notification < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: { maximum: 255 }
  validates :date, presence: true
  validates :read_status, presence: true
end
