ActiveAdmin.register RecordBook do
  menu label: proc { I18n.t('active_admin.record_books.record_books') }

  permit_params :user_id, :specialization_id, :group_id, :intermediate_attestation_id, :custom_number

  index title: proc { I18n.t('active_admin.record_books.record_books') } do
    selectable_column
    column I18n.t('active_admin.record_books.custom_number'), :custom_number
    column I18n.t('active_admin.record_books.user'), :user
    column I18n.t('active_admin.record_books.specialization'), :specialization
    column I18n.t('active_admin.record_books.group'), :group
    column I18n.t('active_admin.record_books.created_at'), :created_at
    actions
  end

  show title: proc { I18n.t('active_admin.record_books.record_book') } do
    attributes_table do
      row I18n.t('active_admin.record_books.custom_number') do |record_book|
        record_book.custom_number
      end
      row I18n.t('active_admin.record_books.user') do |record_book|
        record_book.user
      end
      row I18n.t('active_admin.record_books.specialization') do |record_book|
        record_book.specialization
      end
      row I18n.t('active_admin.record_books.group') do |record_book|
        record_book.group
      end
    end
    active_admin_comments
  end


  filter :custom_number, label: I18n.t('active_admin.record_books.custom_number')
  filter :user, label: I18n.t('active_admin.record_books.user')
  filter :specialization, label: I18n.t('active_admin.record_books.specialization')
  filter :group, label: I18n.t('active_admin.record_books.group')
  filter :created_at, label: I18n.t('active_admin.record_books.created_at')

  form do |f|
    f.inputs I18n.t('active_admin.record_books.record_book_details') do
      f.input :custom_number, label: I18n.t('active_admin.record_books.custom_number')
      f.input :user, label: I18n.t('active_admin.record_books.user')
      f.input :specialization, label: I18n.t('active_admin.record_books.specialization')
      f.input :group, label: I18n.t('active_admin.record_books.group')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.record_books.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.record_books.save_changes'), wrap_element: :button
      end
    end
  end
end
  