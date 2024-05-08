class Semester < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  has_and_belongs_to_many :subjects
end
