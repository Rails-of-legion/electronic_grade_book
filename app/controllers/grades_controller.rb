class GradesController < ApplicationController
  before_action :set_grade, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @pagy, @grades = pagy(Grade.includes(:record_book, :subject).all, items: 10)
  end

  def show; end

  def new
    @grade = Grade.new
  end

  def edit; end

  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        format.html { redirect_to @grade, notice: 'Оценка успешно создана.' }
        format.json { render json: @grade, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @grade.update(grade_params)
      redirect_to @grade, notice: 'Оценка обновлена!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @grade.destroy
    redirect_to grades_path, notice: 'Оценка удалена!'
  end

  private

  def grade_params
    params.require(:grade).permit(:date, :subject_id, :grade, :record_book_id, :is_retake)
  end

  def set_grade
    @grade = Grade.includes(:record_book, :subject).find(params[:id])
  end
end
