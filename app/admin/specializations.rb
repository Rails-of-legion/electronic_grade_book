ActiveAdmin.register Specialization do
  permit_params :name, subject_ids: []

  filter :name

  index do
    column :name
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
    end
    f.inputs 'Subjects' do
      f.input :subjects, as: :check_boxes, collection: Subject.all.map { |s| [s.name, s.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
    end

    panel 'Subjects' do
      table_for specialization.specialities_subjects do
        column 'Name of the item', :subject do |specialities_subject|
          specialities_subject.subject.name
        end
        column :description do |specialities_subject|
          specialities_subject.subject.description
        end
      end
    end

    if specialization.groups.any?
      panel 'Groups' do
        table_for specialization.groups do
          column :name
          column :curator
          column :created_at
          column :updated_at
        end
      end
    end
  end
end
