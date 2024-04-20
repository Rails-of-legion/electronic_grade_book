# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create; end

  def search; end

  def find_user
    date_of_birth = Date.new(
      params[:user][:'date_of_birth(1i)'].to_i,
      params[:user][:'date_of_birth(2i)'].to_i,
      params[:user][:'date_of_birth(3i)'].to_i
    )

    @user = User.find_by(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      middle_name: params[:user][:middle_name],
      phone_number: params[:user][:phone_number],
      date_of_birth: date_of_birth
    )
    serach_user(@user)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    @user = find_user
  end

  def set_password_and_email
    byebug
    @user = User.find(params[:user].delete(:id))
    @user[:status] = true
    if @user.update(user_params)
      UserMailer.registration_confirmation(@user).deliver_later
      sign_in(@user)
      redirect_to root_path, notice: 'Registration was successfully'
    else
      render :set_password_and_email
    end
  end

  private

  def serach_user(user)
    if user && user[:status].blank?
      render :set_password_and_email, status: :unprocessable_entity
    else
      flash[:alert] = 'User not found'
      redirect_to users_find_user_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :status)
  end
end
