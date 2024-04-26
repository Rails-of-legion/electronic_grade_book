class AddRecordBookToGrades < ActiveRecord::Migration[7.1]
  def change
    add_reference :grades, :record_book, foreign_key: true
  end
end
