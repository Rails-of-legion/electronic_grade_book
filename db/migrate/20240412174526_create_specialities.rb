class CreateSpecialities < ActiveRecord::Migration[7.1]
  def change
    create_table :specialities do |t|
      t.string :name
      t.string :students

      t.timestamps
    end
  end
end
