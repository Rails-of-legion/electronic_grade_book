class Grade < ApplicationRecord
  belongs_to :record_book
  validates :grade, presence: true

  def self.ransackable_associations(_auth_object = nil)
    ['record_book']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at grade id id_value record_book_id updated_at]
  end
end
