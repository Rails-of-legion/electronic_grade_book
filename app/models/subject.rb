class Subject < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true

  has_many :semesters_subjects, dependent: :destroy
  has_many :semesters, through: :semesters_subjects, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :intermediate_attestations, dependent: :destroy
  has_many :teachers_subjects, dependent: :destroy
  has_many :teachers, through: :teachers_subjects, source: :teacher, dependent: :destroy
  has_many :specialities_subjects, dependent: :destroy
  has_many :specializations, through: :specialities_subjects

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id name updated_at]
  end
end
