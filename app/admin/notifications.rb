ActiveAdmin.register Notification do
  permit_params :message, :date, :status, user_ids: []
  index do
    selectable_column
    id_column
    column :message
    column :date
    actions
  end

  show do
    attributes_table do
      row :message
      row :date
      row :users, as: :check_boxes, collection: User.all
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Notification Details' do
      f.input :message
      f.input :date
      f.input :users, as: :check_boxes, collection: User.all
    end
    f.actions
  end
end
