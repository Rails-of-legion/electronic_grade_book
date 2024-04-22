class CreateRetakesRecordBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :retakes_record_books do |t|
      t.references :retake, null: false, foreign_key: true
      t.references :record_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
