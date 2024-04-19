class Retake < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :grade

  def self.ransackable_associations(auth_object = nil)
    ["grade", "student", "subject"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "grade_id", "id", "id_value", "student_id", "subject_id", "updated_at"]
  end
end
