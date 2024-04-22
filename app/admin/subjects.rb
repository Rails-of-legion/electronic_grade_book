ActiveAdmin.register Subject do
  permit_params :name, :description, :semester_id, :assessment_type

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :semester_id
    column :assessment_type
    actions
  end

  filter :name
  filter :description
  filter :semester_id
  filter :assessment_type

  form do |f|
    f.inputs 'Subject Details' do
      f.input :name
      f.input :description
      f.input :semester_id
      f.input :assessment_type
    end
    f.actions
  end
end
