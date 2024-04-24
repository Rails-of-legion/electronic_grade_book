class AddDateToGrades < ActiveRecord::Migration[7.1]
  def change
    add_column :grades, :date, :date
  end
end
