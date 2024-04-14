class Attendance < ApplicationRecord
  validates :date, presence: true
  validates :attendance_status, presence: true
  
end
