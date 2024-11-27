class AddIndexToSpecializations < ActiveRecord::Migration[7.1]
  def change
    add_column :specializations, :index, :string, null: false
  end
end
