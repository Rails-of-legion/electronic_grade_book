class CreateSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description
      t.references :semester, null: false, foreign_key: true
      t.text :assessment_type

      t.timestamps
    end
  end
end
