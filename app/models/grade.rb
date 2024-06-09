class Grade < ApplicationRecord
  belongs_to :subject
  belongs_to :record_book

  validates :grade, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date grade id id_value record_book_id subject_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[record_book subject]
  end

  attribute :is_retake, :boolean, default: false

end

