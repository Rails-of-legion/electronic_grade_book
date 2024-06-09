class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /groups
  def index
    if params[:specialization_id].present?
      @pagy, @groups = pagy(Group.where(specialization_id: params[:specialization_id]), items: 10)
    else
      @pagy, @groups = pagy(Group.all, items: 10)
    end

    respond_to do |format|
      format.html
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  def show
    @group = Group.find(params[:id])
    @subjects = @group.specialization.subjects

    respond_to do |format|
      format.json { render json: @subjects }
      format.html
    end
  end

  def form_teacher
    @group = Group.find(params[:group_id])
    @month = params[:month]&.to_i
    @subject = Subject.find_by(id: params[:subject_id])

    if @month && @subject
      start_date = Date.new(Time.current.year, @month, 1)
      end_date = start_date.end_of_month

      @record_books = RecordBook.where(group_id: @group.id)

    end
    respond_to do |format|
      format.html do
        render partial: 'form_teacher',
               locals: { group: @group, month: @month, subject: @subject, record_books: @record_books }
      end
      format.js { render locals: { record_books: @record_books } }
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  
  def group_params
    params.require(:group).permit(:name, :curator_id)
  end
end
