ActiveAdmin.register Subject do
  permit_params :name, :description, :semester_id

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :semester_id
    actions
  end

  filter :name
  filter :description
  filter :semester_id

  form do |f|
    f.inputs 'Subject Details' do
      f.input :name
      f.input :description
      f.input :semester_id
    end
    f.actions
  end
end
