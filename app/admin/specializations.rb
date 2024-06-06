ActiveAdmin.register Specialization do
  menu priority: 3, label: proc { I18n.t('active_admin.specializations.specializations') }

  permit_params :name, subject_ids: []

  index title: proc { I18n.t('active_admin.specializations.specializations') } do
    selectable_column
    id_column
    column I18n.t('active_admin.specializations.name'), :name
    actions
  end

  filter :name, label: I18n.t('active_admin.specializations.name')

  form do |f|
    f.inputs I18n.t('active_admin.specializations.details') do
      f.input :name, label: I18n.t('active_admin.specializations.name')
    end
    f.inputs I18n.t('active_admin.specializations.subjects') do
      f.input :subjects, as: :check_boxes, collection: Subject.all.map { |s| [s.name, s.id] }, label: I18n.t('active_admin.specializations.subjects')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.specializations.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.specializations.save_changes'), wrap_element: :button
      end
    end
  end

  show do
    attributes_table do

    panel I18n.t('active_admin.specializations.subjects') do
      table_for specialization.specialities_subjects do
        column I18n.t('active_admin.specializations.name_of_the_item'), :subject do |specialities_subject|
          specialities_subject.subject.name
        end
        column I18n.t('active_admin.specializations.description') do |specialities_subject|
          specialities_subject.subject.description
        end
      end
    end
  end

    if specialization.groups.any?
      panel I18n.t('active_admin.specializations.groups') do
        table_for specialization.groups do
          column I18n.t('active_admin.specializations.name'), :name
          column I18n.t('active_admin.specializations.curator'), :curator
          column I18n.t('active_admin.specializations.created_at'), :created_at
        end
      end
    end
  end
end
