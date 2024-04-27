class Subject < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true

  belongs_to :semester
  has_many :grades, dependent: :destroy
  has_many :intermediate_attestations, dependent: :destroy
  has_many :teachers_subjects, dependent: :destroy
  has_many :teachers, through: :teachers_subjects, source: :teacher, dependent: :destroy
  has_many :attendance, dependent: :destroy
  has_many :specialities_subjects, dependent: :destroy
  has_many :specializations, through: :specialities_subjects

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id name semester_id updated_at]
  end
end
