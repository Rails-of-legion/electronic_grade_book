class AddIndexToNameInSpecialities < ActiveRecord::Migration[7.1]
  def change
    add_index :specialities, :name, unique: true
  end
end
