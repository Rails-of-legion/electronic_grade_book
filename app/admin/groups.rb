ActiveAdmin.register Group do
  permit_params :name, :curator_id

  index do
    selectable_column
    id_column
    column :name
    column :curator
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Group Details' do
      f.input :name
      f.input :curator, as: :select
    end
    f.actions
  end
end
