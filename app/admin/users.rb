ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation,
                :status, :date_of_birth, :middle_name, :phone_number,
                :first_name, :last_name, role_ids: []

  filter :email
  filter :role, collection: -> { Role.all }
  # Index (Read)
  index do
    selectable_column
    id_column
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

  # Edit/Update and Create
  controller do
    def update
      @user = User.find(params[:id])
      authorize! :update, @user
      if @user.update(permitted_params[:user])
        redirect_to admin_user_path(@user), notice: 'Пользователь обновлен.'
      else
        render :edit
      end
    end

    def create
      @user = User.new(permitted_params[:user])
      authorize! :create, @user
      if @user.save
        redirect_to admin_user_path(@user), notice: 'Пользователь создан.'
      else
        render :new
      end
    end
  end
end
