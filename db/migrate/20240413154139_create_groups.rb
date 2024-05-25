class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :form_of_education
      t.references :curator, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :groups, :curator_id, name: "index_groups_on_curator"
  end
end
