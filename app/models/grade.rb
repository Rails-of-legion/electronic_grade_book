class Grade < ApplicationRecord
  belongs_to :record_book
  validates :grade, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["record_book"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "grade", "id", "id_value", "record_book_id", "updated_at"]
  end
end
