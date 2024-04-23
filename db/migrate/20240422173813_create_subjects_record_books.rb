class CreateSubjectsRecordBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects_record_books do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :record_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
