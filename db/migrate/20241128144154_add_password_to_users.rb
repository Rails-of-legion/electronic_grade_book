class AddPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :save_password, :string
  end
end
