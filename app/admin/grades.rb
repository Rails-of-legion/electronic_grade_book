ActiveAdmin.register Grade do
    permit_params :record_book_id, :grade
  
    index do
      selectable_column
      id_column
      column :record_book
      column :grade
      column :created_at
      actions
    end
  
    filter :record_book
    filter :grade
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :record_book
        f.input :grade
      end
      f.actions
    end
end
