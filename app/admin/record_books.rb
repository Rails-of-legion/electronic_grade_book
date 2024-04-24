ActiveAdmin.register RecordBook do
  permit_params :user_id, :specialization_id, :group_id, :intermediate_attestation_id, retake_ids: []

  index do
    selectable_column
    id_column
    column :user
    column :specialization
    column :group
    column 'Retakes' do |record_book|
      record_book.retakes.count
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user
      row :specialization
      row :group
      row 'Retakes' do |record_book|
        record_book.retakes.count
      end
    end
    active_admin_comments
  end

  filter :user
  filter :specialization
  filter :group
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :specialization
      f.input :group
      f.input :retakes, as: :check_boxes
    end
    f.actions
  end
end
