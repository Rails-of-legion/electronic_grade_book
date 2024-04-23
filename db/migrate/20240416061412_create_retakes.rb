class CreateRetakes < ActiveRecord::Migration[7.1]
  def change
      create_table :retakes do |t|
        t.references :subject, null: false, foreign_key: true
        t.date :date
        t.references :grade, foreign_key: true
  
        t.timestamps
    end
  end
end
