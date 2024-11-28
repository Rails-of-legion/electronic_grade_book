class CreateExaminationReports < ActiveRecord::Migration[7.1]
  def change
    create_table :examination_reports do |t|
      t.string :group, null: false
      t.string :subject
      t.string :attestation
      t.string :teacher
      t.string :student
      t.date :date_of_statement
      t.date :date_until_valid
      t.integer :mark
      t.date :date_of_attestation

      t.timestamps
    end
  end
end
