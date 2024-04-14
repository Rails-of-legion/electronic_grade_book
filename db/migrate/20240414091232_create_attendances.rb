class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.integer :subject_id, null: false, foreign_key: true
      t.integer :student_id, null: false, foreign_key: true
      t.date :date, null: false
      t.string :attendance_status, null: false

      t.timestamps
    end
  end
end
