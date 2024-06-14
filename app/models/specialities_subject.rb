class SpecialitiesSubject < ApplicationRecord
  belongs_to :specialization
  belongs_to :subject

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value specialization_id subject_id updated_at]
  end
end
