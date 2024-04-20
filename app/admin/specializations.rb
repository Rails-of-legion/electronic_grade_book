ActiveAdmin.register Specialization do
  permit_params :name

  filter :name

  index do
    column :name
    actions
  end
end
