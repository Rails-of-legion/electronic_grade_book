class GroupsIntermediateAttestation < ApplicationRecord
  belongs_to :group
  belongs_to :intermediate_attestation

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at group_id id id_value intermediate_attestation_id updated_at]
  end
end
