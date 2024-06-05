ActiveAdmin.register Semester do
  menu label: proc { I18n.t('active_admin.semesters.semesters') }

  permit_params :name, :start_date, :end_date

  index title: proc { I18n.t('active_admin.semesters.semesters') } do
    selectable_column
    column I18n.t('active_admin.semesters.name'), :name
    column I18n.t('active_admin.semesters.start_date'), :start_date
    column I18n.t('active_admin.semesters.end_date'), :end_date
    actions
  end

  filter :name, label: I18n.t('active_admin.semesters.name')
  filter :start_date, label: I18n.t('active_admin.semesters.start_date')
  filter :end_date, label: I18n.t('active_admin.semesters.end_date')
  filter :created_at, label: I18n.t('active_admin.semesters.created_at')

  form do |f|
    f.inputs I18n.t('active_admin.semesters.semester_details') do
      f.input :name, label: I18n.t('active_admin.semesters.name')
      f.input :start_date, label: I18n.t('active_admin.semesters.start_date'), as: :datepicker
      f.input :end_date, label: I18n.t('active_admin.semesters.end_date'), as: :datepicker
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.semesters.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.semesters.save_changes'), wrap_element: :button
      end
    end
  end
end
