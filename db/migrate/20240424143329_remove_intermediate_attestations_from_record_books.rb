class RemoveIntermediateAttestationsFromRecordBooks < ActiveRecord::Migration[7.1]
  def change
    remove_reference :record_books, :intermediate_attestation, index: true, foreign_key: true
  end
end
