ActiveAdmin.register Student do
    permit_params :user_id, :specialization_id, :group_id
  
    index do
      selectable_column
      id_column
      column :user
      column :specialization
      column :group
      column :created_at
      actions
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
  