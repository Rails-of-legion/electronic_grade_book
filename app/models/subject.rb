class Subject < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :assessment_type, presence: true

  belongs_to :semester
  has_many :intermediate_attestations, dependent: :destroy
  has_many :teachers_subjects, dependent: :destroy
  has_many :teachers, through: :teachers_subjects, source: :teacher, dependent: :destroy
  has_many :subjects_record_books, dependent: :destroy
  has_many :record_books, through: :subjects_record_books, dependent: :destroy
  has_many :retakes, dependent: :destroy
  has_many :attendance, dependent: :destroy
  has_many :specialities_subjects, dependent: :destroy
  has_many :specializations, through: :specialities_subjects

  def self.ransackable_attributes(auth_object = nil)
    ["assessment_type", "created_at", "description", "id", "name", "semester_id", "updated_at"]
  end
end
