class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true).includes(:roles), items: 7)
    @total_notifications = @q.result(distinct: true).count
  end

  def show
    @user = User.find(params[:id])
    @notificationsUser = NotificationsUser.where(user_id: @user.id)
    authorize! :read, @user
  end

  def new
    @user = User.new
    authorize! :create, @user
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def create
    if params[:user][:file].present?
      file = params[:user][:file]
      process_excel_file_user(file) # Обрабатываем файл
      # Перенаправление на страницу со всеми пользователями
    respond_to do |format|  
      format.html { redirect_to users_path, notice: t('questions.subjects_create_notice') }
      format.json { head :no_content } # Если нужно, можно вернуть статус 204
    end  
    else
      @user = User.new(user_params)
      authorize! :create, @user
      respond_to do |format|
        if @user.save
          if @user.has_role?(:student) && params[:user][:group_id].present?
            group = Group.find_by(id: params[:user][:group_id])

            if group
              record_book = RecordBook.new(
                user: @user,
                group: group,
                custom_number: rand(1000000000..9999999999)
              )

              if record_book.save
                format.html { redirect_to @user, notice: t('users.create.success_with_record_book') }
                format.json { render json: @user, status: :created }
              else
                format.html { render :new, alert: t('users.create.failed_to_create_record_book') + record_book.errors.full_messages.join(', ') }
                format.json { render json: record_book.errors, status: :unprocessable_entity }
              end
            else
              format.html { redirect_to @user, notice: t('questions.users_create_notice') }
              format.json { render json: @user, status: :created }
            end
          else
            format.html { redirect_to @user, notice: t('questions.users_create_notice') }
            format.json { render json: @user, status: :created }
          end
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def generate_pdf(student)
    IndividualReport.new(student).generate_report
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to @user, notice: t('questions.users_update_notice')
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

    redirect_to root_path, alert: t('questions.users_edit_password_alert')
  end

  def edit_email
    @user = User.find(params[:id])
    return if current_user == @user

    redirect_to root_path, alert: t('questions.users_edit_email_alert')
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update(edit_password_params)
      redirect_to user_path(@user), notice: t('questions.users_update_password_notice')
    else
      render :edit_password
    end
  end

  def update_email
    @user = User.find(params[:id])
    if @user.update(edit_email_params)
      redirect_to user_path(@user), notice: t('questions.users_update_email_notice')
    else
      render :edit_email
    end
  end

  def select_group
    session[:group_id] = params[:group_id] if params[:group_id].present?
    Rails.logger.debug "Group ID set in session: #{session[:group_id]}"
    redirect_to some_path
  end

  def export_users_to_xlsx
    @users = User.all

    package = Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: "Users") do |sheet|
        sheet.add_row ["Фамилия", "Имя", "Отчество", "Электронная почта", "Пароль"] # Заголовки столбцов

        @users.each do |user|
          sheet.add_row [user.last_name, user.first_name, user.middle_name, user.email, user.save_password]
        end
      end
    end

    # Отправляем файл пользователю
    send_data package.to_stream.read, filename: "users.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end
  def status
    @users = User.all
  end

  def update_status
    params[:user].each do |id, user_params|
      user = User.find(id)
      user.update(status: user_params[:status] == '1') # Обновляем статус
    end
    redirect_to status_users_path, notice: t('users.status_updated')
  end
  private

  def set_notification_user
    @notification_user = NotificationsUser.find_by(notification_id: params[:id], user_id: current_user.id)
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :middle_name, :email,
      :password, :password_confirmation, :save_password ,:status, :expelled, :expelled_at, role_ids: []
    )
  end

  def edit_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def edit_email_params
    params.require(:user).permit(:email)
  end


  def generate_secure_password
    length = 12 # Длина пароля
    lowercase = ('a'..'z').to_a
    uppercase = ('A'..'Z').to_a
    digits = ('0'..'9').to_a
    special_characters = %w[! @  $ % ^ & * ( ) - _ = +]

    # Убедимся, что в пароле есть хотя бы один символ каждого типа
    password = []
    password << lowercase.sample
    password << uppercase.sample
    password << digits.sample
    password << special_characters.sample

    # Заполняем оставшуюся часть пароля случайными символами
    (length - 4).times { password << (lowercase + uppercase + digits + special_characters).sample }

    # Перемешиваем пароль, чтобы символы были в случайном порядке
    password.shuffle.join
  end

  def process_excel_file_user(file)
    spreadsheet = Roo::Spreadsheet.open(file.tempfile)
  
    spreadsheet.each_with_index do |row, index|
      next if index == 0 # Пропускаем заголовок
  
      user = User.new
      user.first_name = row[1]
      user.last_name = row[0]
      user.middle_name = row[2]
      user.email = row[3]
      user.password = generate_secure_password # Генерируем безопасный пароль
      user.password_confirmation = user.password
      user.status = true
      user.expelled = true
  
      if user.save
        user.add_role(:student) # Присваиваем роль студент
      else
        Rails.logger.error "Ошибка сохранения пользователя на строке #{index + 1}: #{user.errors.full_messages.join(", ")}"
      end
    end
  end


end
