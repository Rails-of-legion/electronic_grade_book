ActiveAdmin.register RecordBook do
  permit_params :subject_id, :student_id, :teacher_id, :intermediate_attestation_id, retake_ids: []

  index do
    selectable_column
    id_column
    column :subject
    column :student
    column :teacher
    column :intermediate_attestation
    column 'Retakes' do |record_book|
      record_book.retakes.count
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :subject
      row :teacher
      row :intermediate_attestation
      row :date
      row 'Retakes' do |record_book|
        record_book.retakes.count
      end
    end
    active_admin_comments
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
      f.input :retakes, as: :check_boxes
    end
    f.actions
  end
end
