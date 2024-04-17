class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :middle_name, :phone_number, :email,
      :password, :password_confirmation, roles: []
    )
  end
end
