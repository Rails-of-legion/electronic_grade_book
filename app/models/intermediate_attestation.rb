class IntermediateAttestation < ApplicationRecord
  belongs_to :subject, optional: false
  belongs_to :teacher, class_name: 'User'
  has_many :groups_intermediate_attestations, dependent: :destroy
  has_many :groups, through: :groups_intermediate_attestations, dependent: :destroy
  has_many :grades, foreign_key: :subject_id

  validates :name, :assessment_type, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      assessment_type created_at id id_value name
      subject_id teacher_id updated_at group_id
      intermediate_attestation_id
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[groups groups_intermediate_attestations subject teacher]
  end
end
