class Student < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :specialization, required: true
  belongs_to :group, required: true

  validates :user, presence: true
  validates :specialization, presence: true
  validates :group, presence: true
end
