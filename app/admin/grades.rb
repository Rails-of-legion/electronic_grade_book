ActiveAdmin.register Grade do
  permit_params :grade, :date, :subject_id, :record_book_id

  index do
    selectable_column
    id_column
    column :student do |grade|
      grade.record_book.user.name
    end
    column :record_book
    column :subject
    column :grade
    column :date
    column :created_at
    actions
  end

  filter :record_book_user_first_name, as: :string, filters: [:cont], label: 'Student Name'
  filter :subject
  filter :grade
  filter :date
  filter :created_at

  form do |f|
    f.inputs do
      f.input :record_book, as: :select, collection: RecordBook.joins(:user).where(users: { id: User.with_role(:student).pluck(:id) }), label: 'Студент', member_label: Proc.new { |rb| rb.user.name }
      f.input :subject
      f.input :grade
      f.input :date
    end
    f.actions
  end
  

  controller do
    def create
      @grade = Grade.new(permitted_params[:grade])
      create!
    end
  end
end
