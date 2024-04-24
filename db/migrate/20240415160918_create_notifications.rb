class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.datetime :date
      t.string :read_status

      t.timestamps
    end
  end
end
