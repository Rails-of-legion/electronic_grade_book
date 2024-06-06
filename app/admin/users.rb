ActiveAdmin.register User do
  menu label: proc { I18n.t('active_admin.users.users') }

  permit_params :email, :password, :password_confirmation,
                :status, :date_of_birth, :middle_name, :phone_number,
                :first_name, :last_name, role_ids: []

  index title: proc { I18n.t('active_admin.users.users') } do
    selectable_column
    id_column
    column I18n.t('active_admin.users.name'), :name
    column I18n.t('active_admin.users.email'), :email
    column I18n.t('active_admin.users.roles') do |user|
      user.roles.pluck(:name).join(', ')
    end
    column I18n.t('active_admin.users.status'), :status
    column I18n.t('active_admin.users.created_at'), :created_at
    actions
  end

  filter :email, label: I18n.t('active_admin.users.email')
  filter :role, collection: -> { Role.all }, label: I18n.t('active_admin.users.role')
  filter :first_name, label: I18n.t('active_admin.users.first_name')
  filter :middle_name, label: I18n.t('active_admin.users.middle_name')
  filter :last_name, label: I18n.t('active_admin.users.last_name')
  filter :record_book_custom_number, as: :string, label: I18n.t('active_admin.users.record_book_number'), joins: :record_book
  filter :group, collection: -> { Group.all }, label: I18n.t('active_admin.users.group')
  filter :record_book_specialization_id_eq, as: :select, collection: lambda {
                                                                       Specialization.all
                                                                     }, label: I18n.t('active_admin.users.education_program'), joins: :record_book

  form do |f|
    f.inputs I18n.t('active_admin.users.user_details') do
      f.input :first_name, label: I18n.t('active_admin.users.first_name')
      f.input :last_name, label: I18n.t('active_admin.users.last_name')
      f.input :middle_name, label: I18n.t('active_admin.users.middle_name')
      f.input :email, label: I18n.t('active_admin.users.email')
      f.input :password, label: I18n.t('active_admin.users.password')
      f.input :password_confirmation, label: I18n.t('active_admin.users.password_confirmation')
      f.input :status, label: I18n.t('active_admin.users.status')
      f.input :date_of_birth, label: I18n.t('active_admin.users.date_of_birth')
      f.input :phone_number, label: I18n.t('active_admin.users.phone_number')
      f.input :roles, as: :check_boxes, label: I18n.t('active_admin.users.roles')
    end
    f.actions do
      if f.object.new_record?
        f.action :submit, label: I18n.t('active_admin.users.create'), wrap_element: :button
      else
        f.action :submit, label: I18n.t('active_admin.users.save_changes'), wrap_element: :button
      end
    end
  end

  show do
    attributes_table do
      row I18n.t('active_admin.users.name') do |user|
        user.name
      end
      row I18n.t('active_admin.users.email') do |user|
        user.email
      end
      row I18n.t('active_admin.users.date_of_birth') do |user|
        user.date_of_birth
      end
      row I18n.t('active_admin.users.phone_number') do |user|
        user.phone_number
      end
      row I18n.t('active_admin.users.roles') do |user|
        user.roles.pluck(:name).join(', ')
      end
      if user.record_book
        row I18n.t('active_admin.users.record_book_number') do |user|
          user.record_book&.custom_number
        end
        row I18n.t('active_admin.users.group') do |user|
          user.record_book&.group&.name
        end
        row I18n.t('active_admin.users.specialization') do |user|
          user.record_book&.specialization&.name
        end
        row I18n.t('active_admin.users.subjects_of_the_current_semester') do |user|
          user.record_book&.specialization&.subjects
        end
        row I18n.t('active_admin.users.grades') do |user|
          subjects = user.record_book&.specialization&.subjects
          table_for subjects do
            column I18n.t('active_admin.users.subject'), &:name
            column I18n.t('active_admin.users.grades') do |subject|
              grades = subject.grades
              grades.pluck(:grade).join(', ')
            end
          end
        end
      end
    end
    active_admin_comments
  end

  controller do
    def update
      @user = User.find(params[:id])
      authorize! :update, @user
      if @user.update(permitted_params[:user])
        redirect_to admin_user_path(@user), notice: I18n.t('active_admin.users.user_updated')
      else
        render :edit
      end
    end

    def create
      @user = User.new(permitted_params[:user])
      authorize! :create, @user
      if @user.save
        redirect_to admin_user_path(@user), notice: I18n.t('active_admin.users.user_created')
      else
        render :new
      end
    end
  end
end
