class IntermediateAttestation < ApplicationRecord
  belongs_to :subject, optional: false

  validates :name, :date, :assessment_type, presence: true
  validates :max_grade, presence: true, numericality: { less_than_or_equal_to: 10 }
end
