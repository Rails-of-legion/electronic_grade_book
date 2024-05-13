class GroupsIntermediateAttestation < ApplicationRecord
  belongs_to :group
  belongs_to :intermediate_attestation

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "group_id", "id", "id_value", "intermediate_attestation_id", "updated_at"]
  end
end
