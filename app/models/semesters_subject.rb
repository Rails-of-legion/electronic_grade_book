class SemestersSubject < ApplicationRecord
  belongs_to :semester
  belongs_to :subject

  def self.ransackable_attributes(auth_object = nil)
    [
      "created_at",
      "semester_id",
      "subject_id",
      "updated_at"
    ]
  end
end
