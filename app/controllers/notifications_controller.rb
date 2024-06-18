class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show edit update destroy mark_as_read]
  before_action :set_users, only: %i[edit new index]  # Добавляем index сюда

  # GET /notifications
  def index
    @q = Notification.ransack(params[:q])
    @notifications = @q.result.includes(:users, :notifications_users)

    respond_to do |format|
      format.html
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/1
  def show
    @notification_user = NotificationsUser.find_by(notification: @notification)
    @users = @notification.users
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
    @users = User.all

    respond_to do |format|
      if @notification.save
        # Associate users with the notification correctly
        params[:notification][:user_ids].each do |user_id|
          # Check if a NotificationsUser record already exists
          existing_record = NotificationsUser.find_by(notification: @notification, user_id: user_id)
          # If it doesn't exist, create a new one
          unless existing_record
            NotificationsUser.create(notification: @notification, user_id: user_id)
          end
        end

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
    if @notification.update(notification_params)
      @notification.notifications_users.destroy_all
      params[:notification][:user_ids].each do |user_id|
        NotificationsUser.create(notification: @notification, user_id: user_id)
      end
  
      respond_to do |format|
        format.html { redirect_to @notification, notice: 'Уведомление успешно обновлено.' }
        format.json { render :show, status: :ok, location: @notification }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Уведомление было успешно удалено.'
  end

  # POST /notifications/1/mark_as_read
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

  def set_users
    @users = User.all
  end

  def notification_params
    params.require(:notification).permit(:message, :date, user_ids: [])
  end
end
