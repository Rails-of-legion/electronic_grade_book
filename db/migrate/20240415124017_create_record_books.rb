class CreateRecordBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :record_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :specialization, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :intermediate_attestation, null: false, foreign_key: true
      t.string :custom_number, null: false

      t.timestamps
    end
  end
end
