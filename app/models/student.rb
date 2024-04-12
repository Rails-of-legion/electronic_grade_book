class Student < ApplicationRecord
  validates :speciality_id, presence: true
  validates :group_id, presence: true

  belongs_to :user
  # belongs_to :speciality
  # belongs_to :group
end
