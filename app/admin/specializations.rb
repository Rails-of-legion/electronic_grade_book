ActiveAdmin.register Specialization do
  permit_params :name

  filter :name

  index do
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
    end
    panel "Subjects" do
      table_for specialization.subjects do
        column :name
      end
    end
  end
end

