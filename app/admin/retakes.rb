# app/admin/retake.rb
ActiveAdmin.register Retake do
  permit_params :subject_id, :student_id, :grade_id

  index do
    selectable_column
    id_column
    column :subject
    column :student
    column :grade
    actions
  end

  form do |f|
    f.inputs 'Retake Details' do
      f.input :subject
      f.input :student
      f.input :grade
    end
    f.actions
  end
end
