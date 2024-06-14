class Semester < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  has_many :semesters_subjects, dependent: :destroy
  has_many :subjects, through: :semesters_subjects, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at end_date id id_value name start_date updated_at]
  end
end
