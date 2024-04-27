class AddSpecializationToGroups < ActiveRecord::Migration[7.1]
  def change
    add_reference :groups, :specialization, null: false, foreign_key: true
  end
end
