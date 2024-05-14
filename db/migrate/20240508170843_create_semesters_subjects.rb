class CreateSemestersSubjects < ActiveRecord::Migration[7.1]
  def change
      create_table :semesters_subjects, id: false do |t|
        t.references :semester, null: false, foreign_key: true
        t.references :subject, null: false, foreign_key: true
      t.timestamps
    end
  end
end
