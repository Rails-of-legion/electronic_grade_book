class SpecialitiesSubject < ApplicationRecord
  belongs_to :specialization
  belongs_to :subject

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "specialization_id", "subject_id", "updated_at"]
  end
end
