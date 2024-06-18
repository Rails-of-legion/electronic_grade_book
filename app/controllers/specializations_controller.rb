class SpecializationsController < ApplicationController
  before_action :set_specialization, only: %i[show edit update destroy]
  before_action :set_subject, only: %i[edit new]
  load_and_authorize_resource

  # GET /specializations
  def index
    @q = Specialization.ransack(params[:q])
    @pagy, @specializations = pagy(@q.result.includes(:subjects, :specialities_subjects), items: 10)
  end

  # GET /specializations/1
  def show; end

  # GET /specializations/new
  def new
    @specialization = Specialization.new
  end

  # GET /specializations/1/edit
  def edit; end

  # POST /specializations
  def create
    @specialization = Specialization.new(specialization_params)
    if @specialization.save
      flash[:notice] = 'Specialization was successfully created.'
      render :show
    else
      flash.now[:alert] = 'Failed to create specialization.'
      render :new
    end
  end

  # PATCH/PUT /specializations/1
  def update
    if @specialization.update(specialization_params)
      flash[:notice] = 'Specialization was successfully updated.'
      render :show
    else
      flash.now[:alert] = 'Failed to update specialization.'
      render :edit
    end
  end

  # DELETE /specializations/1
  def destroy
    if @specialization.destroy
      flash[:notice] = 'Specialization was successfully destroyed.'
      redirect_to specializations_url
    else
      flash[:alert] = 'Failed to destroy specialization.'
      redirect_to @specialization
    end
  end

  private

  def set_subject
    @subjects = Subject.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_specialization
    @specialization = Specialization.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def specialization_params
    params.require(:specialization).permit(:name, subject_ids: [])
  end
end
