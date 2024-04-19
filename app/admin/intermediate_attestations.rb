ActiveAdmin.register IntermediateAttestation do
  permit_params :subject_id, :name, :date, :max_grade, :assessment_type

  index do
    selectable_column
    id_column
    column :subject
    column :name
    column :date
    column :max_grade
    column :assessment_type
    actions
  end

  form do |f|
    f.inputs 'Intermediate Attestation Details' do
      f.input :subject
      f.input :name
      f.input :date, as: :datepicker
      f.input :max_grade
      f.input :assessment_type, as: :select, collection: ['экзамен', 'зачет', 'контрольная работа'] # выпадающий список с типами аттестации
    end
    f.actions
  end
end
