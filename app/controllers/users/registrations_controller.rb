# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    @user = User.find(params[:id])
    
    if update_resource(@user, user_params)
      redirect_to users_path, notice: 'User updated successfully.'
    else
      Rails.logger.debug "User errors: #{@user.errors.full_messages}"
      render :edit
    end
  end

  # Поиск пользователя по параметрам
  def search; end

  def find_user
    @user = User.find_by(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      middle_name: params[:user][:middle_name],
    )
    search_user
  end

  def set_password_and_email
    @user = User.find(params[:user].delete(:id))
    @user[:status] = true
    if @user.update(user_params)
      UserMailer.registration_confirmation(@user).deliver_later
      sign_in(@user)
      redirect_to root_path, notice: t('questions.register_notice') 
    else
      render :set_password_and_email
    end
  end

  protected

  # Метод для обновления пользователя без необходимости изменения пароля
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:current_password))
    else
      super
    end
  end

  private

  def search_user
    if @user 
      if @user[:status].blank?
        render :set_password_and_email, status: :unprocessable_entity
      else
        flash[:alert] = t('questions.user_already_exists')
        redirect_to edit_user_registration_path(@user)
      end
    else
      flash[:alert] = t('questions.register_alert') 
      redirect_to users_search_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :middle_name, :email, :password, :password_confirmation, :status, :expelled, :expelled_at, role_ids: [])
  end
end
