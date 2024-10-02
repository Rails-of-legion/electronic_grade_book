class AddProfilingToSubjects < ActiveRecord::Migration[7.1]
  def change
    add_column :subjects, :profiling, :string
  end
end
