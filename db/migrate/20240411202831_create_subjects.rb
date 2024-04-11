class CreateSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description
      t.integer :semester_id
      t.string :assessment_type

      t.timestamps
    end
  end
end
