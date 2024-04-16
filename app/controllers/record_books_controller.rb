class RecordBooksController < ApplicationController
    before_action :set_record_book, only: %i[show edit update destroy]
  
    def create
      @record_book = RecordBook.new(record_book_params)
  
      if @record_book.save
        redirect_to @record_book, notice: "Зачетная книжка успешно создана!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      if @record_book.update(record_book_params)
        redirect_to @record_book, notice: "Зачетная книжка обновлена!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @record_book.destroy
      redirect_to record_books_path, notice: "Зачетная книжка удалена!"
    end
  
    def show
    end
  
    def index
      @record_books = RecordBook.all
    end
  
    def new
      @record_book = RecordBook.new
    end
  
    def edit
    end
  
    private
  
    def record_book_params
      params.require(:record_book).permit(:subject_id, :student_id, :teacher_id, :intermediate_attestation_id)
    end
  
    def set_record_book
      @record_book = RecordBook.find(params[:id])
    end
  end