ActiveAdmin.register Notification do
  menu priority: 3, label: proc { I18n.t('active_admin.notifications.notifications') }

  permit_params :message, :date, :status, user_ids: []

  index title: proc { I18n.t('active_admin.notifications.notifications') } do
    selectable_column
    id_column
    column I18n.t('active_admin.notifications.message'), :message
    column I18n.t('active_admin.notifications.date'), :date
    actions
  end

  filter :message, label: proc { I18n.t('active_admin.notifications.message') }
  filter :date, label: proc { I18n.t('active_admin.notifications.date') }
  filter :users, label: proc { I18n.t('active_admin.notifications.users') }

  show do
    attributes_table do
      row I18n.t('active_admin.notifications.message') do |notification|
        notification.message
      end
      row I18n.t('active_admin.notifications.date') do |notification|
        notification.date
      end
      row I18n.t('active_admin.notifications.users') do |notification|
        notification.users.map(&:name).join(', ')
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs I18n.t('active_admin.notifications.notification_details') do
      f.input :message, label: I18n.t('active_admin.notifications.message')
      f.input :date, label: I18n.t('active_admin.notifications.date')
      f.input :users, as: :check_boxes, collection: User.all, label: I18n.t('active_admin.notifications.users')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.notifications.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.notifications.save_changes'), wrap_element: :button
      end
    end    
  end
end
