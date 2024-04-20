class Attendance < ApplicationRecord
  validates :date, presence: true
  validates :attendance_status, presence: true

  belongs_to :subject
  belongs_to :student

  def self.ransackable_associations(_auth_object = nil)
    %w[student subject]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[attendance_status created_at date id id_value student_id subject_id updated_at]
  end
end
