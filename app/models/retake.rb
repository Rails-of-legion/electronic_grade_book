class Retake < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :grade

  validates :subject, presence: true
  validates :student, presence: true
  validates :grade, presence: true
end