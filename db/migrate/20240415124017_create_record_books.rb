class CreateRecordBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :record_books do |t|
      t.references :student, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.references :intermediate_attestation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
