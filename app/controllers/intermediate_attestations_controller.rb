class IntermediateAttestationsController < ApplicationController
  before_action :set_intermediate_attestation, only: %i[show edit update destroy]
  before_action :set_collections, only: %i[new create edit update]
  load_and_authorize_resource

  def index
    @q = IntermediateAttestation.ransack(params[:q])
    @intermediate_attestations = @q.result(distinct: true).includes(:subject)
  
    @pagy, @intermediate_attestations = pagy(@intermediate_attestations, items: 10)
  
    respond_to do |format|
      format.html
      format.json { render json: @intermediate_attestations }
    end
  end

  def show
    @intermediate_attestation = IntermediateAttestation.find(params[:id])
    @groups = @intermediate_attestation.groups

    respond_to do |format|
      format.html
      format.pdf do
        headers['Content-Disposition'] = 'attachment; filename="intermediate_attestation_report.pdf"'
        render pdf: 'intermediate_attestation_report'
      end
    end
  end

  def new

  end

  def edit

  end

  def create
    @intermediate_attestation = IntermediateAttestation.new(intermediate_attestation_params)

    if @intermediate_attestation.save
      redirect_to @intermediate_attestation, notice: 'Intermediate attestation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @intermediate_attestation.update(intermediate_attestation_params)
      redirect_to @intermediate_attestation, notice: 'Intermediate attestation was successfully updated.'
    else
      @subjects = Subject.all
      render :edit
    end
  end

  def destroy
    @intermediate_attestation.destroy
    redirect_to intermediate_attestations_url, notice: 'Intermediate attestation was successfully destroyed.'
  end

  private

  def set_intermediate_attestation
    @intermediate_attestation = IntermediateAttestation.find(params[:id])
  end

  def set_collections
    @groups = Group.all
    @subjects = Subject.all
    @teachers = User.with_role(:teacher)
  end

  def intermediate_attestation_params
    params.require(:intermediate_attestation).permit(:name, :date, :assessment_type, :subject_id, :teacher_id, group_ids: [])
  end
end
