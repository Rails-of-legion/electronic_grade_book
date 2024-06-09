class AddIsRetakeToGrades < ActiveRecord::Migration[7.1]
  def change
    add_column :grades, :is_retake, :boolean
  end
end
