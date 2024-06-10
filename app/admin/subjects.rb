ActiveAdmin.register Subject do
  menu priority: 3, label: proc { I18n.t('active_admin.subjects.subjects') }

  permit_params :name, :description

  index title: proc { I18n.t('active_admin.subjects.subjects') } do
    selectable_column
    id_column
    column I18n.t('active_admin.subjects.name'), :name
    column I18n.t('active_admin.subjects.description'), :description
    actions
  end

  filter :name, label: I18n.t('active_admin.subjects.name')
  filter :description, label: I18n.t('active_admin.subjects.description')

  show do
    attributes_table do
      panel I18n.t('active_admin.subjects.subject') do
        table_for subject.specialities_subjects do
          column I18n.t('active_admin.subjects.name'), :subject do |specialities_subject|
            specialities_subject.subject.name
          end
          column I18n.t('active_admin.subjects.description') do |specialities_subject|
            specialities_subject.subject.description
          end
        end
      end
    end
  end
  
  
  
  form do |f|
    f.inputs I18n.t('active_admin.subjects.subject_details') do
      f.input :name, label: I18n.t('active_admin.subjects.name')
      f.input :description, label: I18n.t('active_admin.subjects.description')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.subjects.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.subjects.save_changes'), wrap_element: :button
      end
    end    
  end
end
