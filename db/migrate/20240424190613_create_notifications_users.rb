class CreateNotificationsUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications_users do |t|
      t.references :notification, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :status
      
      t.timestamps
    end
  end
end
