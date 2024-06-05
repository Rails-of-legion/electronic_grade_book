ActiveAdmin.register RecordBook do
  permit_params :user_id, :specialization_id, :group_id, :intermediate_attestation_id, :custom_number

  index do
    selectable_column
    column :custom_number
    column :user
    column :specialization
    column :group
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :custom_number
      row :user
      row :specialization
      row :group
    end
    active_admin_comments
  end
  filter :custom_number
  filter :user
  filter :specialization
  filter :group
  filter :created_at

  form do |f|
    f.inputs do
      f.input :custom_number
      f.input :user
      f.input :specialization
      f.input :group
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes :user, :specialization, :group
    end
  end
end
