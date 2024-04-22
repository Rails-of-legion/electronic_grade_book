class CreateSubjectRecordBooks < ActiveRecord::Migration[6.0] # Укажите вашу версию Rails, если она отличается
  def change
    create_table :subject_record_books do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :record_book, null: false, foreign_key: true

      t.timestamps
    end

    # Убедитесь, что внешние ключи и связи между таблицами установлены правильно
    add_index :subject_record_books, [:subject_id, :record_book_id], unique: true
  end
end
