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
  filter :curator, as: :select, collection: User.with_role(:teacher).map { |u| [u.name, u.id] }
  filter :specialization

  form do |f|
    f.inputs 'Group Details' do
      f.input :name
      f.input :curator, as: :select, collection: User.with_role(:teacher).map { |u| [u.name, u.id] }
      f.input :specialization
    end
    f.actions
  end
end
