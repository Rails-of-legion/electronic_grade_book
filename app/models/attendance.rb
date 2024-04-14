class Attendance < ApplicationRecord
  validates :date, presence: true
  validates :attendance_status, presence: true

  belongs_to :subject
  belongs_to :student
end
