class RecordBook < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :teacher, class_name: 'User'
  belongs_to :intermediate_attestation
  has_many :grades, dependent: :destroy
  has_many :subject_record_books, dependent: :destroy
  has_many :subjects, through: :subject_record_books

  def self.ransackable_associations(auth_object = nil)
    ["grades", "intermediate_attestation", "student", "subjects", "teacher"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "intermediate_attestation_id", "student_id", "subject_id", "teacher_id", "updated_at"]
  end
end
