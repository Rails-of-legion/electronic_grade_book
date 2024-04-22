class RecordBook < ApplicationRecord
  belongs_to :student
  belongs_to :teacher, class_name: 'User'
  belongs_to :intermediate_attestation
  has_many :subjects_record_books, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :subjects, through: :subjects_record_books, dependent: :destroy

  def self.ransackable_associations(_auth_object = nil)
    %w[grades intermediate_attestation student subjects_record_books teacher]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value intermediate_attestation_id student_id teacher_id
       updated_at]
  end

  def subjects_list
    subjects.map(&:name).join(', ')
  end  

end
