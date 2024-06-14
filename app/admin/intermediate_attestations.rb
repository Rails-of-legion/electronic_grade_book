ActiveAdmin.register IntermediateAttestation do
  menu priority: 3, label: proc { I18n.t('active_admin.intermediate_attestations.intermediate_attestations') }

  permit_params :name, :date, :assessment_type, :subject_id, :teacher_id, group_ids: []

  index title: proc { I18n.t('active_admin.intermediate_attestations.intermediate_attestations') } do
    selectable_column
    id_column
    column I18n.t('active_admin.intermediate_attestations.name'), :name
    column I18n.t('active_admin.intermediate_attestations.date'), :date
    column I18n.t('active_admin.intermediate_attestations.assessment_type'), :assessment_type
    column I18n.t('active_admin.intermediate_attestations.subject'), :subject
    column I18n.t('active_admin.intermediate_attestations.groups'), :groups
    column I18n.t('active_admin.intermediate_attestations.teacher'), :teacher
    actions
  end

  show do |_attestation|
    attributes_table do
      row I18n.t('active_admin.intermediate_attestations.name'), &:name
      row I18n.t('active_admin.intermediate_attestations.date'), &:date
      row I18n.t('active_admin.intermediate_attestations.assessment_type'), &:assessment_type
      row I18n.t('active_admin.intermediate_attestations.subject') do |attestation|
        attestation.subject.name
      end
      row I18n.t('active_admin.intermediate_attestations.groups') do |attestation|
        attestation.groups.map(&:name).join(', ')
      end
      row I18n.t('active_admin.intermediate_attestations.teacher') do |attestation|
        attestation.teacher.name
      end
    end
    active_admin_comments
  end

  filter :name, label: I18n.t('active_admin.intermediate_attestations.name')
  filter :date, label: I18n.t('active_admin.intermediate_attestations.date')
  filter :assessment_type, label: I18n.t('active_admin.intermediate_attestations.assessment_type')
  filter :subject, label: I18n.t('active_admin.intermediate_attestations.subject')
  filter :groups, label: I18n.t('active_admin.intermediate_attestations.group')

  form do |f|
    f.inputs I18n.t('active_admin.intermediate_attestations.intermediate_attestation_details') do
      f.input :name, label: I18n.t('active_admin.intermediate_attestations.name')
      f.input :date, label: I18n.t('active_admin.intermediate_attestations.date')
      f.input :assessment_type, label: I18n.t('active_admin.intermediate_attestations.assessment_type')
      f.input :subject, label: I18n.t('active_admin.intermediate_attestations.subject')
      f.input :group_ids, as: :check_boxes, collection: Group.all,
                          label: I18n.t('active_admin.intermediate_attestations.groups')
      f.input :teacher, as: :select, collection: User.with_role(:teacher),
                        label: I18n.t('active_admin.intermediate_attestations.teacher')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.intermediate_attestations.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.intermediate_attestations.save_changes'), wrap_element: :button
      end
    end
  end

  controller do
    def default_title
      'Мой заголовок'
    end

    def scoped_collection
      super.includes :groups, :subject, :teacher
    end
  end
end
