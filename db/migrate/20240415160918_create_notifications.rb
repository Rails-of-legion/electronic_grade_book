class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.datetime :date
      t.boolean :status

      t.timestamps
    end
  end
end
