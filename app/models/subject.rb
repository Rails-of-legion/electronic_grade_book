class Subject < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :assessment_type, presence: true

  belongs_to :semester
  has_many :intermediate_attestations
  has_many :teachers_subjects
  has_many :teachers, through: :teachers_subjects, source: :teacher
  has_many :record_books, dependent: :destroy
  has_many :record_books, dependent: :destroy
  has_many :retakes, dependent: :destroy
  has_many :attendance, dependent: :destroy
end
