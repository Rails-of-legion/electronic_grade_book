ActiveAdmin.register Grade do
  permit_params :record_book_id, :subject_id, :grade, :date

  index do
    selectable_column
    id_column
    column :record_book
    column :grade
    column :date
    column :subject do |grade|
      grade.record_book.specialization.subjects
    end
    column :created_at
    actions
  end

  filter :record_book
  filter :subject
  filter :grade
  filter :date
  filter :created_at

  form do |f|
    f.inputs do
      f.input :record_book
      f.input :subject do |grade|
        grade.record_book.specialization.subjects
      end
      f.input :grade
      f.input :date
    end
    f.actions
  end
end
