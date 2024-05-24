class RecordBooksController < ApplicationController
  before_action :set_record_book, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @record_books = RecordBook.all
  end

  def show
    @month = params[:month] || Time.zone.today.month
  end

  def new
    @record_book = RecordBook.new
    authorize! :create, @record_book
  end

  def edit
    authorize! :update, @record_book
  end

  def create
    @record_book = RecordBook.new(record_book_params)
    authorize! :create, @record_book

    if @record_book.save
      redirect_to @record_book, notice: 'Зачетная книжка успешно создана!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @record_book
    if @record_book.update(record_book_params)
      redirect_to @record_book, notice: 'Зачетная книжка обновлена!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @record_book
    @record_book.destroy
    redirect_to record_books_path, notice: 'Зачетная книжка удалена!'
  end

  private

  def record_book_params
    params.require(:record_book).permit(:record_book_id, :intermediate_attestation_id)
  end

  def set_record_book
    @record_book = RecordBook.find(params[:id])
  end
end
