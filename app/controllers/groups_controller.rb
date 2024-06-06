class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /groups

  def index
    if params[:specialization_id].present? 
      @groups = Group.where(specialization_id: params[:specialization_id])
    else
      @groups = Group.all 
    end

    respond_to do |format|
      format.html 
      format.json { render json: @groups } 
    end
  end
  # GET /groups/1
  def show
    @month = params[:month] || Time.zone.today.month
    @record_books = @group.record_books.includes(:user)
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
