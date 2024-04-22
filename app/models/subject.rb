class Subject < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :assessment_type, presence: true

  belongs_to :semester
  has_many :intermediate_attestations, dependent: :destroy
  has_many :teachers_subjects, dependent: :destroy
  has_many :teachers, through: :teachers_subjects, source: :teacher, dependent: :destroy
  has_many :subject_record_books, dependent: :destroy
  has_many :record_books, through: :subject_record_books, dependent: :destroy
  has_many :retakes, dependent: :destroy
  has_many :attendance, dependent: :destroy
end
