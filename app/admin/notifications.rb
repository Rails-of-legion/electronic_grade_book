ActiveAdmin.register Notification do
  # Позволяет редактировать и удалять записи
  permit_params :title, :content, :user_ids

  # Отображаемые поля в списке
  index do
    selectable_column
    id_column
    column :title
    column :content
    column :created_at
    actions
  end

  # Отображаемые поля в форме
  form do |f|
    f.inputs "Notification Details" do
      f.input :title
      f.input :content
    end
    f.inputs "Users" do
      f.input :users, as: :check_boxes
    end
    f.actions
  end
end