class AddHoursAndCreditUnitsToSubjects < ActiveRecord::Migration[7.1]
  def change
    add_column :subjects, :hours, :integer, null: false
    add_column :subjects, :credit_units, :integer, null: false
  end
end
