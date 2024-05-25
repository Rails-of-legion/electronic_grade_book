class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @notificationsUser = NotificationsUser.where(user_id: @user.id)
    authorize! :read, @user
  end

  def generate_pdf(student)
    IndividualReport.new(student).generate_report
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
    return if @user == current_user

    redirect_to root_path, alert: 'Access denied!'
    nil
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def edit_password
    @user = User.find(params[:id])
    return if current_user == @user

    redirect_to root_path, alert: 'Access denied!'
    nil
  end

  def edit_email
    @user = User.find(params[:id])
    return if current_user == @user

    redirect_to root_path, alert: 'Access denied!'
    nil
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

  def set_notification_user
    @notification_user = NotificationsUser.find_by(notification_id: params[:id], user_id: current_user.id)
  end

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
