class SemestersController < ApplicationController
  before_action :set_semester, only: %i[show edit update destroy]

  def index
    @semesters = Semester.all
  end

  def show; end

  def new
    @semester = Semester.new
  end

  def edit; end

  def create
    @semester = Semester.new(semester_params)

    if @semester.save
      redirect_to @semester, notice: 'Semester was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @semester.update(semester_params)
      redirect_to @semester, notice: 'Semester was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @semester.destroy
      redirect_to semesters_url, notice: 'Semester was successfully destroyed.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_semester
    @semester = Semester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to semesters_url, notice: 'Semester not found.'
  end

  def semester_params
    params.require(:semester).permit(:name, :start_date, :end_date)
  end
end
