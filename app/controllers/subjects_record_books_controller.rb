class SubjectsRecordBooksController < ApplicationController
    before_action :set_subjects_record_book, only: [:show, :edit, :update, :destroy]
  
    def index
      @subjects_record_books = SubjectsRecordBook.all
    end
  
    def show
    end
  
    def new
      @subjects_record_book = SubjectsRecordBook.new
    end
  
    def edit
    end
  
    def create
      @subjects_record_book = SubjectsRecordBook.new(subjects_record_book_params)
  
      if @subjects_record_book.save
        redirect_to @subjects_record_book, notice: 'Subjects record book was successfully created.'
      else
        render :new
      end
    end
  
    def update
      if @subjects_record_book.update(subjects_record_book_params)
        redirect_to @subjects_record_book, notice: 'Subjects record book was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @subjects_record_book.destroy
      redirect_to subjects_record_books_url, notice: 'Subjects record book was successfully destroyed.'
    end
  
    private
  
    def set_subjects_record_book
      @subjects_record_book = SubjectsRecordBook.find(params[:id])
    end
  
    def subjects_record_book_params
      params.require(:subjects_record_book).permit(:subject_id, :record_book_id)
    end
  end
  