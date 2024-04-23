class RetakesRecordBook < ApplicationRecord
  belongs_to :retake
  belongs_to :record_book

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id record_book_id retake_id updated_at]
  end
end
