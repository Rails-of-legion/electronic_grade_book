ActiveAdmin.register Retake do
  permit_params :subject_id, :student_id, :date, :grade_id, record_book_ids: []

  index do
    selectable_column
    id_column
    column :subject
    column :student
    column :grade
    column :record_books do |retake|
      retake.record_books.map { |record_book| record_book.retakes.count }
    end
    actions
  end

  filter :subject
  filter :student
  filter :teacher
  filter :grade

  form do |f|
    f.inputs 'Retake Details' do
      f.input :subject
      f.input :student
      f.input :grade
      f.input :date
      f.input :record_books, as: :check_boxes
    end
    f.actions
  end
end
