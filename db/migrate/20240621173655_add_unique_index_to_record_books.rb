class AddUniqueIndexToRecordBooks < ActiveRecord::Migration[7.1]
  def change
    add_index :record_books, :custom_number, unique: true
  end
end
