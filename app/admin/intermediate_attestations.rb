# app/admin/intermediate_attestation.rb
ActiveAdmin.register IntermediateAttestation do
  permit_params :name, :date, :assessment_type, :subject_id, :teacher_id, :group_id 

  index do
    selectable_column
    id_column
    column :name
    column :date
    column :assessment_type
    column :subject
    actions
  end

  filter :name
  filter :date
  filter :assessment_type
  filter :subject

  form do |f|
    f.inputs 'Intermediate Attestation Details' do
      f.input :name
      f.input :date
      f.input :assessment_type
      f.input :subject
      f.input :teacher, as: :select, collection: User.with_role(:teacher)
      f.input :group, as: :select, collection: Group.all
    end
    f.actions
  end
end
