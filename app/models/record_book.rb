class RecordBook < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :specialization, optional: false
  belongs_to :group, optional: false
  has_many :record_books_intermediate_attestations, dependent: :destroy
  has_many :intermediate_attestations, through: :record_books_intermediate_attestations
  has_many :grades, dependent: :destroy

  validates :custom_number, presence: true

  def self.ransackable_associations(_auth_object = nil)
    %w[grades intermediate_attestation user group specialization]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at user_id id intermediate_attestation_id updated_at custom_number]
  end

  def subjects_list
    subjects.map(&:name).join(', ')
  end
end
