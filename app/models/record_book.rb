class RecordBook < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'
  belongs_to :user, optional: false
  belongs_to :specialization, optional: false
  belongs_to :group, optional: false
  belongs_to :intermediate_attestation
  has_many :grades, dependent: :destroy
  has_many :retakes_record_books, dependent: :destroy
  has_many :retakes, through: :retakes_record_books
  

  def self.ransackable_associations(_auth_object = nil)
    %w[grades intermediate_attestation subject teacher retakes]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value intermediate_attestation_id subject_id teacher_id
       updated_at]
  end
end
