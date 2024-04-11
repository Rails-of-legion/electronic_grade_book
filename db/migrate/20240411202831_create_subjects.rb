class CreateSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects do |t|
      t.string :name, presence: true, length: { minimum: 3 }
      t.text :description, presence: true
      t.integer :semester_id, presence: true
      t.string :assessment_type, presence: true

      t.timestamps
    end
  end
end
