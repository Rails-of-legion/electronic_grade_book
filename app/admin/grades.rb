ActiveAdmin.register Grade do
  menu label: proc { I18n.t('active_admin.grades.grades') }

  permit_params :grade, :date, :subject_id, :record_book_id

  index title: proc { I18n.t('active_admin.grades.grades') } do
    selectable_column
    id_column
    column I18n.t('active_admin.grades.student'), :student do |grade|
      grade.record_book.user.name
    end
    column I18n.t('active_admin.grades.record_book'), :record_book
    column I18n.t('active_admin.grades.subject'), :subject
    column I18n.t('active_admin.grades.grade'), :grade
    column I18n.t('active_admin.grades.date'), :date
    column I18n.t('active_admin.grades.created_at'), :created_at
    actions
  end

  filter :record_book_user_first_name, as: :string, filters: [:cont], label: I18n.t('active_admin.grades.student_first_name')
  filter :subject, label: I18n.t('active_admin.grades.subject')
  filter :grade, label: I18n.t('active_admin.grades.grade')
  filter :date, label: I18n.t('active_admin.grades.date')
  filter :created_at, label: I18n.t('active_admin.grades.created_at')

  form do |f|
    f.inputs I18n.t('active_admin.grades.grade_details') do
      f.input :record_book, as: :select, collection: RecordBook.joins(:user).where(users: { id: User.with_role(:student).select(:id) }), label: I18n.t('active_admin.grades.student'), member_label: proc { |rb|
                                                                                                                                                                           rb.user.name
                                                                                                                                                                         }
      f.input :subject, label: I18n.t('active_admin.grades.subject')
      f.input :grade, label: I18n.t('active_admin.grades.grade')
      f.input :date, label: I18n.t('active_admin.grades.date')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.grades.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.grades.save_changes'), wrap_element: :button
      end
    end
  end

  controller do
    def create
      @grade = Grade.new(permitted_params[:grade])
      create!
    end
  end
end
