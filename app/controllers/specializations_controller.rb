class SpecializationsController < ApplicationController
  before_action :set_specialization, only: %i[show edit update destroy]
  before_action :set_subject, only: %i[edit new]
  load_and_authorize_resource

  # GET /specializations
  def index
    @q = Specialization.ransack(params[:q])
    @pagy, @specializations = pagy(@q.result.includes(:subjects, :specialities_subjects), items: 7)
    @total_specializations = @q.result(distinct: true).count
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
      flash[:notice] = t('questions.specialization_create_notice')
      render :show
    else
      flash.now[:alert] = t('questions.specialization_create_alert')
      render :new
    end
  end

  # PATCH/PUT /specializations/1
  def update
    if @specialization.update(specialization_params)
      flash[:notice] = t('questions.specialization_update_notice')
      render :show
    else
      flash.now[:alert] = t('questions.specialization_update_alert')
      render :edit
    end
  end

  # DELETE /specializations/1
  def destroy
    if @specialization.destroy
      flash[:notice] = t('questions.specialization_destroy_notice')
      redirect_to specializations_url
    else
      flash[:alert] = t('questions.specialization_destroy_alert')
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
    params.require(:specialization).permit(:name, :index, subject_ids: [])
  end
end
