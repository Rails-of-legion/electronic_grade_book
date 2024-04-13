class Student < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :speciality, required: true
  belongs_to :group, required: true

  validates :user, presence: true
  validates :speciality, presence: true
  validates :group, presence: true
end
