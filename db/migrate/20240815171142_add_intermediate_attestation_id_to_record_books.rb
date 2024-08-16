class AddIntermediateAttestationIdToRecordBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :record_books, :intermediate_attestation_id, :integer
  end
end
