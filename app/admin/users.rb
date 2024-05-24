ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation,
                :status, :date_of_birth, :middle_name, :phone_number,
                :first_name, :last_name, role_ids: []

  filter :email
  filter :role, collection: -> { Role.all }
  filter :first_name
  filter :middle_name
  filter :last_name
  filter :record_book_custom_number, as: :string, label: 'Record book number', joins: :record_book
  filter :group, collection: -> { Group.all }
  filter :record_book_specialization_id_eq, as: :select, collection: lambda {
                                                                       Specialization.all
                                                                     }, label: 'Education program', joins: :record_book
  # Index (Read)
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :roles do |user|
      user.roles.pluck(:name).join(', ')
    end
    column :status
    column :created_at
    actions
  end

  # New/Create
  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :middle_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :status
      f.input :date_of_birth
      f.input :phone_number
      f.input :roles, as: :check_boxes
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :status
      row :date_of_birth
      row :phone_number
      row :roles do |user|
        user.roles.pluck(:name).join(', ')
      end
      if user.record_book
        row 'Record book number' do |user|
          user.record_book&.custom_number
        end
        row :group do |user|
          user.record_book&.group&.name
        end
        row 'Specialization' do |user|
          user.record_book&.specialization&.name
        end
        row 'Subjects of the current semester' do |user|
          user.record_book&.specialization&.subjects
        end
        row 'Grades' do |user|
          subjects = user.record_book&.specialization&.subjects
          table_for subjects do
            column 'Subject', &:name
            column 'Grades' do |subject|
              grades = subject.grades
              grades.pluck(:grade).join(', ')
            end
          end
        end
      end
    end
    active_admin_comments
  end

  # Edit/Update and Create
  controller do
    def update
      @user = User.find(params[:id])
      authorize! :update, @user
      if @user.update(permitted_params[:user])
        redirect_to admin_user_path(@user), notice: 'User updated.'
      else
        render :edit
      end
    end

    def create
      @user = User.new(permitted_params[:user])
      authorize! :create, @user
      if @user.save
        redirect_to admin_user_path(@user), notice: 'User created.'
      else
        render :new
      end
    end
  end
end
