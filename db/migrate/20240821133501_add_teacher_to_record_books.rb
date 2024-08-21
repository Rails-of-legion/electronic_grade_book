class AddTeacherToRecordBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :record_books, :teacher, null: false, foreign_key: { to_table: :users }
  end
end
