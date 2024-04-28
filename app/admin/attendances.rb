ActiveAdmin.register Attendance do
  permit_params :date, :attendance_status, :subject_id

  index do
    selectable_column
    id_column
    column :date
    column :attendance_status
    column :subject
    actions
  end

  filter :date
  filter :attendance_status
  filter :subject

  form do |f|
    f.inputs 'Детали посещаемости' do
      f.input :date
      f.input :attendance_status
      f.input :subject
    end
    f.actions
  end
end
