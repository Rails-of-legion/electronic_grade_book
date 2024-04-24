class IntermediateAttestation < ApplicationRecord
  belongs_to :subject, optional: false
  has_many :record_books, through: :record_books_intermediate_attestations

  validates :name, :date, :assessment_type, presence: true
  validates :max_grade, presence: true, numericality: { less_than_or_equal_to: 10 }

  def self.ransackable_associations(_auth_object = nil)
    %w[record_books subject]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[assessment_type created_at date id id_value max_grade name subject_id updated_at]
  end
end
