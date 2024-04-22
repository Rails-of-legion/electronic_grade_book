class SubjectRecordBooksController < ApplicationController
    before_action :set_subject_record_book, only: [:show, :edit, :update, :destroy]
  
    def index
      @subject_record_books = SubjectRecordBook.all
    end
  
    def show
    end
  
    def new
      @subject_record_book = SubjectRecordBook.new
    end
  
    def edit
    end
  
    def create
      @subject_record_book = SubjectRecordBook.new(subject_record_book_params)
      if @subject_record_book.save
        redirect_to @subject_record_book, notice: 'Subject record book was successfully created.'
      else
        render :new
      end
    end
  
    def update
      if @subject_record_book.update(subject_record_book_params)
        redirect_to @subject_record_book, notice: 'Subject record book was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @subject_record_book.destroy
      redirect_to subject_record_books_url, notice: 'Subject record book was successfully destroyed.'
    end
  
    private
  
    def set_subject_record_book
      @subject_record_book = SubjectRecordBook.find(params[:id])
    end
  
    def subject_record_book_params
      params.require(:subject_record_book).permit(:subject_id, :record_book_id)
    end
end
