class Retake < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :grade

  def self.ransackable_associations(_auth_object = nil)
    %w[grade student subject]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date grade_id id id_value student_id subject_id updated_at]
  end
end
