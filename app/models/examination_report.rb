class ExaminationReport < ApplicationRecord
  validates :group, presence: true
  validates :date_until_valid, presence: true
  validates :subject, presence: true
  validates :attestation, presence: true
  validates :teacher, presence: true
  validates :date_of_statement, presence: true
  validates :mark, presence: true
  validates :date_of_attestation, presence: true
end
