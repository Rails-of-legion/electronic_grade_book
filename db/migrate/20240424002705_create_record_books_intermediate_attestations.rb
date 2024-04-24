class CreateRecordBooksIntermediateAttestations < ActiveRecord::Migration[7.1]
  def change
    create_table :record_books_intermediate_attestations do |t|
      t.references :record_book, null: false, foreign_key: true
      t.references :intermediate_attestation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
