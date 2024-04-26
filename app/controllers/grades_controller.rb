class GradesController < ApplicationController
  before_action :set_grade, only: %i[show edit update destroy]

  def index
    @grades = Grade.all
  end

  def show; end

  def new
    @grade = Grade.new
  end

  def edit; end

  def create
    date_grade = Date.new(Time.now.year, params[:month].to_i, params[:grade][:date].to_i)
    params[:grade][:date] = date_grade
    @grade = Grade.new(grade_params)

    if @grade.save
      redirect_to record_book_path(@grade.record_book)
    else
      render :new, status: :unprocessable_entity
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
    params.require(:grade).permit(:date, :subject_id, :grade, :record_book_id)
  end

  def set_grade
    @grade = Grade.find(params[:id])
  end
end
