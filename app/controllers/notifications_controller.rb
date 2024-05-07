class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show update destroy]

  # GET /notifications
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  def show

  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit; end


  # PATCH/PUT /notifications/1
  def update
    @notification_user.update(status: true)
    redirect_to notifications_path, notice: 'Уведомление было отмечено как прочитанное.'
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Notification was successfully destroyed.'
  end

  def mark_as_read
    @notification_user = NotificationsUser.find(params[:id])
    @notification_user.update(status: true)
  
    redirect_to user_path(current_user), notice: 'Уведомление отмечено как прочитанное.' 
  end

  private
  def set_notification_user
    @notification_user = NotificationsUser.find_by(notification_id: params[:id], user_id: current_user.id)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def notification_params
    params.require(:notification).permit(:message, :date, :read_status, :user_id)
  end
end
