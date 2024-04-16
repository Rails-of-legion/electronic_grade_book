class RecordBook < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :teacher, class_name: 'User'
  belongs_to :intermediate_attestation
  has_many :grades, dependent: :destroy
end
