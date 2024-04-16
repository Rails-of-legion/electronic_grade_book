class StudentsController < ApplicationController
    before_action :set_student, only: %i[show edit update destroy]
  
    def create
      @student = Student.new(student_params)
  
      if @student.save
        redirect_to @student, notice: "Студент успешно создан!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      if @student.update(student_params)
        redirect_to @student, notice: "Данные студента обновлены!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @student.destroy
      redirect_to students_path, notice: "Студент удален!"
    end
  
    def show
    end
  
    def index
      @students = Student.all
    end
  
    def new
      @student = Student.new
    end
  
    def edit
    end
  
    private
  
    def student_params
      params.require(:student).permit(:user_id, :specialization_id, :group_id)
    end
  
    def set_student
      @student = Student.find(params[:id])
    end
  end