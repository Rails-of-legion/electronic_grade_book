class GradesController < ApplicationController
    before_action :set_grade, only: %i[show edit update destroy]
  
    def create
      @grade = Grade.new(grade_params)
  
      if @grade.save
        redirect_to @grade, notice: "Оценка успешно создана!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      if @grade.update(grade_params)
        redirect_to @grade, notice: "Оценка обновлена!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @grade.destroy
      redirect_to grades_path, notice: "Оценка удалена!"
    end
  
    def show
    end
  
    def index
      @grades = Grade.all
    end
  
    def new
      @grade = Grade.new
    end
  
    def edit
    end
  
    private
  
    def grade_params
      params.require(:grade).permit(:record_book_id, :grade)
    end
  
    def set_grade
      @grade = Grade.find(params[:id])
    end
  end