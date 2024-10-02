class SubjectsController < ApplicationController
  before_action :set_subject, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    subjects = current_user.student? ? student_subjects : teacher_subjects
    subjects = search_subjects(subjects)

    @q = subjects.ransack(params[:q])
    @pagy, @subjects = pagy(@q.result(distinct: true), items: 7)
    nil unless current_user.teacher?

    @total_subjects = @q.result(distinct: true).count
  end

  def show; end

  def new
    @subject = Subject.new
  end

  def edit; end

  def create
    if params[:subject][:file].present?
      file = params[:subject][:file]
      process_excel_file(file) # Обрабатываем файл
  
      # Перенаправление на страницу со всеми предметами
      redirect_to subjects_path, notice: t('questions.subjects_create_notice')
    else
      respond_to do |format|  
        if @subject.save
          format.html { redirect_to subject_url(@subject), notice: t('questions.subjects_create_notice') }
          format.json { render :show, status: :created, location: @subject }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @subject.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subject_url(@subject), notice: t('questions.subjects_update_notice') }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url, notice: t('questions.subjects_destroy_notice') }
      format.json { head :no_content }
    end
  end

  def group_subjects_spec
    group_ids = params[:group_ids].split(',')
    groups = Group.where(id: group_ids)
    subjects = groups.map(&:specialization).flat_map(&:subjects).uniq

    respond_to do |format|
      format.json { render json: subjects }
    end
  end

  def group_subjects
    group = Group.find(params[:id])
    @subjects = group.specialization.subjects

    respond_to do |format|
      format.json { render json: @subjects }
    end
  end

  private

  def process_excel_file(file)
    spreadsheet = Roo::Spreadsheet.open(file.tempfile)
  
    spreadsheet.each_with_index do |row, index|
      next if index == 0 # Пропускаем заголовок
  
      subject = Subject.new
      subject.name = row[0]          # Имя
      subject.hours = row[1]         # Часы
      subject.credit_units = row[2]   # Кредитные единицы
      subject.description = row[3]    # Описание
      subject.profiling = row[4]      # Профилирование
      
      unless subject.save
        Rails.logger.error "Ошибка сохранения предмета на строке #{index + 1}: #{subject.errors.full_messages.join(", ")}"
      end
    end
  end

  def student_subjects
    record_book = current_user.record_book
    record_book ? record_book.group.specialization.subjects : []
  end

  def teacher_subjects
    Subject.all
  end

  def search_subjects(subjects)
    return subjects if params[:search].blank?

    search_query = "%#{params[:search].downcase}%"
    subjects.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', search_query, search_query)
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :description, :semester_id, :hours, :credit_units, :profiling)
  end
end
