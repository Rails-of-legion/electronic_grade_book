class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.integer :subject_id, null: false
      t.integer :record_book_id, null: false
      t.date :date, null: false
      t.string :attendance_status, null: false

      t.timestamps
    end
  end
end
