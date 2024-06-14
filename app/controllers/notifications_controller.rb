class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show edit update destroy mark_as_read]

  # GET /notifications
  def index
    @notifications = Notification.all
    @notifications_users = NotificationsUser.where(user: current_user)
  end

  # GET /notifications/1
  def show
    @notification_user = NotificationsUser.find_by(notification: @notification, user: current_user)
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit; end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        NotificationsUser.create(notification: @notification, user: current_user)
        format.html { redirect_to @notification, notice: 'Уведомление успешно создано.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  def update
    @notification_user = NotificationsUser.find_by(notification: @notification, user: current_user)
    if @notification && @notification_user
      if @notification.update(notification_params)
        @notification_user.update(status: true)
        redirect_to notifications_path, notice: 'Уведомление было отмечено как прочитанное.'
      else
        render :edit
      end
    else
      redirect_to notifications_path, alert: 'Уведомление не найдено.'
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Уведомление было успешно удалено.'
  end

  def mark_as_read
    @notification_user = NotificationsUser.find_by(notification: @notification, user: current_user)
    if @notification_user
      @notification_user.update(status: true)
      redirect_to user_path(current_user), notice: 'Уведомление отмечено как прочитанное.'
    else
      redirect_to notifications_path, alert: 'Уведомление не найдено.'
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:message, :date)
  end
end
