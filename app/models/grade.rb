class Grade < ApplicationRecord
  belongs_to :record_book
  validates :grade, presence: true
end
