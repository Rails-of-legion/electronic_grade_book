class RecordBooksController < ApplicationController
  before_action :set_record_book, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @q = RecordBook.includes(:user, :specialization, :group).ransack(params[:q])
    @pagy, @record_books = pagy(@q.result, items: 7)
    @total_record_books = @q.result(distinct: true).count

    if params[:group_id].present?
      @record_books = @record_books.where(group_id: params[:group_id])
    end

    respond_to do |format|
      format.html
      format.json { render json: @record_books.to_json(include: { user: { only: [:id, :first_name, :last_name, :middle_name] } }) }
    end
  end

  def show
    @month = params[:month] || Time.zone.today.month
    @grades = @record_book.grades.where("extract(month from date) = ?", @month)
    @subjects = @record_book.specialization.subjects
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
      redirect_to @record_book, notice: I18n.t('questions.record_books_create_notice')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @record_book
    if @record_book.update(record_book_params)
      redirect_to @record_book, notice: t('questions.record_books_update_notice')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @record_book
    @record_book.destroy
    redirect_to record_books_path, notice: t('questions.record_books_destroy_notice')
  end

  private

  def record_book_params
    params.require(:record_book).permit(:user_id, :specialization_id, :group_id, :custom_number)
  end

  def set_record_book
    @record_book = RecordBook.includes(:user).find(params[:id])
  end
end
