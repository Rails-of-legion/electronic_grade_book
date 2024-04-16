class CreateGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :grades do |t|
      t.references :record_book, null: false, foreign_key: true
      t.integer :grade

      t.timestamps
    end
  end
end
