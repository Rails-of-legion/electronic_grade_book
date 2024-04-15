class CreateTeachersSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :teachers_subjects do |t|
      t.references :teacher, foreign_key: { to_table: :users } 
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
