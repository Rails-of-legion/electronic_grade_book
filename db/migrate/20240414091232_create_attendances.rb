class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.integer :subject_id
      t.integer :student_id
      t.date :date
      t.string :attendance_status

      t.timestamps
    end
  end
end
