ActiveAdmin.register Subject do
  menu priority: 3, label: proc { I18n.t('active_admin.subjects.subjects') }

  permit_params :name, :description, semester_ids: [], specialization_ids: []

  index title: proc { I18n.t('active_admin.subjects.subjects') } do
    selectable_column
    id_column
    column I18n.t('active_admin.subjects.name'), :name
    column I18n.t('active_admin.subjects.description'), :description
    column :semesters do |subject|
      subject.semesters.map do |semester|
        link_to semester.name, admin_semester_path(semester)
      end.join(', ').html_safe
    end
    column :specializations do |subject|
      subject.specializations.map do |specialization|
        link_to specialization.name, admin_specialization_path(specialization)
      end.join(', ').html_safe
    end
    actions
  end

  filter :name, label: I18n.t('active_admin.subjects.name')
  filter :description, label: I18n.t('active_admin.subjects.description')
  filter :semesters
  filter :specializations

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
      f.input :semesters, as: :check_boxes, collection: Semester.all.map { |s| [s.name, s.id] }
      f.input :specializations, as: :check_boxes, collection: Specialization.all.map { |s| [s.name, s.id] }
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
