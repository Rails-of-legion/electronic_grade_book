class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true), items: 10)
  end

  def new
    @user = User.new
    authorize! :create, @user
  end

  def create
    @user = User.new(user_params)
    authorize! :create, @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

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
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy
    redirect_to users_path
  end

  def edit_password
    @user = User.find(params[:id])
    return if current_user == @user

    redirect_to root_path, alert: 'Access denied!'
  end

  def edit_email
    @user = User.find(params[:id])
    return if current_user == @user

    redirect_to root_path, alert: 'Access denied!'
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update(edit_password_params)
      redirect_to user_path(@user), notice: 'Password updated.'
    else
      render :edit_password
    end
  end

  def update_email
    @user = User.find(params[:id])
    if @user.update(edit_email_params)
      redirect_to user_path(@user), notice: 'Email updated.'
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
      :password, :password_confirmation, :status, :date_of_birth, role_ids: []
    )
  end

  def edit_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def edit_email_params
    params.require(:user).permit(:email)
  end
end
