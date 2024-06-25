class GradesController < ApplicationController
  before_action :set_grade, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @q = Grade.ransack(params[:q])
    @pagy, @grades = pagy(@q.result.includes(:record_book, :subject, record_book: :user), items: 10)
  end

  def show; end

  def new
    @grade = Grade.new
  end

  def edit; end

  def create
    @grade = Grade.new(grade_params)
    @grade.date = parse_date(grade_params[:date])

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
    @grade.date = parse_date(grade_params[:date])

    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to @grade, notice: 'Оценка обновлена!' }
        format.json { render json: @grade, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @grade.destroy
    redirect_to grades_path, notice: 'Оценка удалена!'
  end

  def find
    @grade = Grade.find_by(date: parse_date(params[:date]), subject_id: params[:subject_id],
                           record_book_id: params[:record_book_id])
    render json: @grade
  end

  private

  def grade_params
    params.require(:grade).permit(:date, :subject_id, :grade, :record_book_id, :is_retake)
  end

  def set_grade
    @grade = Grade.find(params[:id])
  end

  def parse_date(date_string)
    Time.zone.parse(date_string)
  rescue StandardError
    nil
  end
end
