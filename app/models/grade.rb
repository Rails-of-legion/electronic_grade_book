class Grade < ApplicationRecord
  belongs_to :record_book
  validates :grade, presence: true

  has_one :subject, through: :record_book
  has_one :semester, through: :subject
  has_one :teacher, through: :record_book
end
