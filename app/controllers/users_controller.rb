class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  
    respond_to do |format|
      format.html
      format.pdf do
        headers["Content-Disposition"] = "attachment; filename=\"user_report-#{@user.id}.pdf\""
        render :pdf => "user_report"
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def edit_email
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update(edit_password_params)
      redirect_to user_path(@user), notice: 'password updated'
    else
      render :edit_password
    end
  end

  def update_email
    @user = User.find(params[:id])
    if @user.update(edit_email_params)
      redirect_to user_path(@user), notice: 'email updated'
    else
      render :edit_email
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :middle_name, :phone_number, :email,
      :password, :password_confirmation, roles: []
    )
  end

  def edit_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def edit_email_params
    params.require(:user).permit(:email)
  end
end
