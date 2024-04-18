# app/admin/notification.rb
ActiveAdmin.register Notification do
  permit_params :message, :date, :read_status, :user_id

  index do
    selectable_column
    id_column
    column :message
    column :date
    column :read_status
    actions
  end

  form do |f|
    f.inputs 'Notification Details' do
      f.input :message
      f.input :date
      f.input :read_status
      f.input :user
    end
    f.actions
  end
end
