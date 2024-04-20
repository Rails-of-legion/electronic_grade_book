ActiveAdmin.register RecordBook do
    permit_params :subject_id, :student_id, :teacher_id, :intermediate_attestation_id
  
    index do
      selectable_column
      id_column
      column :subject
      column :student
      column :teacher
      column :intermediate_attestation
      column :created_at
      actions
    end
  
    filter :subject
    filter :student
    filter :teacher
    filter :intermediate_attestation
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :subject
        f.input :student
        f.input :teacher
        f.input :intermediate_attestation
      end
      f.actions
    end
end
