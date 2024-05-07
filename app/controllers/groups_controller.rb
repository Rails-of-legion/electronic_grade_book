class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/1
  def show
    @month = params[:month] || Time.zone.today.month
    @record_books = @group.record_books
  end

  # GET /groups/new
  def new
    authorize! :create, Group
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    authorize! :update, @group
  end

  # POST /groups
  def create
    authorize! :create, Group
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    authorize! :update, @group
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    authorize! :destroy, @group
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
