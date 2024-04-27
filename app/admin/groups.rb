ActiveAdmin.register Group do
  permit_params :name, :curator_id, :specialization_id

  index do
    selectable_column
    id_column
    column :name
    column :curator
    column :specialization
    actions
  end

  filter :name
  filter :curator
  filter :specialization

  form do |f|
    f.inputs 'Group Details' do
      f.input :name
      f.input :curator
      f.input :specialization
    end
    f.actions
  end
end