ActiveAdmin.register Group do
  menu priority: 3, label: proc { I18n.t('active_admin.groups.groups') }

  permit_params :name, :curator_id, :specialization_id

  index title: proc { I18n.t('active_admin.groups.groups') } do
    selectable_column
    id_column
    column I18n.t('active_admin.groups.name'), :name
    column I18n.t('active_admin.groups.curator'), :curator
    column I18n.t('active_admin.groups.specialization'), :specialization
    actions
  end

  filter :name, label: I18n.t('active_admin.groups.name')
  filter :specialization, label: I18n.t('active_admin.groups.specialization')

  form do |f|
    f.inputs I18n.t('active_admin.groups.group_details') do
      f.input :name, label: I18n.t('active_admin.groups.name')
      f.input :curator, as: :select, collection: User.with_role(:teacher).map { |u| [u.name, u.id] }, label: I18n.t('active_admin.groups.curator')
      f.input :specialization, label: I18n.t('active_admin.groups.specialization')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.groups.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.groups.save_changes'), wrap_element: :button
      end
    end    
  end
end
