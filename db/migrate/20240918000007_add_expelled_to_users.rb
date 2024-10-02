class AddExpelledToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :expelled, :boolean, default: false
    add_column :users, :expelled_at, :datetime
  end
end
