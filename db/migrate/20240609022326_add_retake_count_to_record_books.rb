class AddRetakeCountToRecordBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :record_books, :retake_count, :integer, default: 0
  end
end
