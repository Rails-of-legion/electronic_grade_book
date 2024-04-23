class CreateSpecialitiesSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :specialities_subjects do |t|
      t.references :specialization, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
