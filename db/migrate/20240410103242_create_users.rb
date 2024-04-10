class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.date :date_of_birth
      t.string :email
      t.string :password
      t.boolean :status

      t.timestamps
    end
  end
end
