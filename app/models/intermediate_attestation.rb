class IntermediateAttestation < ApplicationRecord
  belongs_to :subject, optional: false
  belongs_to :teacher, class_name: 'User'
  has_many :groups_intermediate_attestations, dependent: :destroy
  has_many :groups, through: :groups_intermediate_attestations, dependent: :destroy

  validates :name, :date, :assessment_type, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[assessment_type created_at date id id_value name subject_id teacher_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[record_books record_books_intermediate_attestations subject teacher]
  end
end
