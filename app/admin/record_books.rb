ActiveAdmin.register RecordBook do
  permit_params :user_id, :specialization_id, :group_id, :intermediate_attestation_id

  index do
    selectable_column
    id_column
    column :user
    column :specialization
    column :group
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user
      row :specialization
      row :group
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
    end
    f.actions
  end
end
