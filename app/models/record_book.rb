class RecordBook < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :specialization, optional: false
  belongs_to :group, optional: false
  has_many :grades, dependent: :destroy

  validates :custom_number, presence: true, uniqueness: true

  def self.ransackable_associations(_auth_object = nil)
    %w[grades intermediate_attestation user group specialization]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at user_id id intermediate_attestation_id updated_at custom_number retake_count]
  end

  def subjects_list
    subjects.map(&:name).join(', ')
  end

  def student_name
    user.name
  end
end
