class AddIndexToSpecializations < ActiveRecord::Migration[7.1]
  def change
    add_column :specializations, :index, :integer, null: false
  end
end
