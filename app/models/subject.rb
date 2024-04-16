class Subject < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :assessment_type, presence: true

  belongs_to :semester
  has_many :intermediate_attestations
  has_many :teachers_subjects
  has_many :teachers, through: :teachers_subjects, source: :teacher
  has_many :record_books, dependent: :destroy
  has_many :record_books
  has_many :retakes
  has_many :attendance
end
