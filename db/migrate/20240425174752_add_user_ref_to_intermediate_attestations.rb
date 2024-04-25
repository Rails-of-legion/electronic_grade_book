class AddUserRefToIntermediateAttestations < ActiveRecord::Migration[7.1]
  def change
    add_reference :intermediate_attestations, :teacher, foreign_key:  { to_table: :users } 
  end
end
