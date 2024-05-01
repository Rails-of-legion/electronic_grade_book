class CreateIntermediateAttestations < ActiveRecord::Migration[7.1]
  def change
    create_table :intermediate_attestations do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :name
      t.date :date
      t.string :assessment_type

      t.timestamps
    end
  end
end
