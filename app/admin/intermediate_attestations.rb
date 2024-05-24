# app/admin/intermediate_attestation.rb
ActiveAdmin.register IntermediateAttestation do
  permit_params :name, :date, :assessment_type, :subject_id, :teacher_id, group_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :date
    column :assessment_type
    column :subject
    column :groups
    column :teacher
    actions
  end

  filter :name
  filter :date
  filter :assessment_type
  filter :subject
  filter :groups

  form do |f|
    f.inputs 'Intermediate Attestation Details' do
      f.input :name, label: 'Name:'
      f.input :date, label: 'Date:'
      f.input :assessment_type, label: 'Assessment Type:'
      f.input :subject, label: 'Subject:'
      f.input :group_ids, as: :check_boxes, collection: Group.all, label: 'Groups:'
      f.input :teacher, as: :select, collection: User.with_role(:teacher), label: 'Teacher:'
    end
    f.actions
  end
end
