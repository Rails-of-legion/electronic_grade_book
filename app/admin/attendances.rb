ActiveAdmin.register Attendance do
  permit_params :subject_id, :date, :attendance_status

  index do
    selectable_column
    id_column
    column :subject
    column :date
    column :attendance_status
    actions
  end

  form do |f|
    f.inputs 'Attendance Details' do
      f.input :subject
      f.input :date, as: :datepicker
      f.input :attendance_status, as: :select, collection: %w[присутствовал отсутствовал опоздал] # выпадающий список со статусами посещаемости
    end
    f.actions
  end
end
