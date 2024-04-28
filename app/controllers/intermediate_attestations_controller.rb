class IntermediateAttestationsController < ApplicationController
  before_action :set_intermediate_attestation, only: %i[show edit update destroy]

  def index
    @intermediate_attestations = IntermediateAttestation.all
  end

  def show
    @record_books = @intermediate_attestation.record_books
  end

  def new
    @intermediate_attestation = IntermediateAttestation.new
    @subjects = Subject.all
  end

  def edit
    @subjects = Subject.all
  end

  def create
    @intermediate_attestation = IntermediateAttestation.new(intermediate_attestation_params)

    if @intermediate_attestation.save
      redirect_to @intermediate_attestation, notice: 'Intermediate attestation was successfully created.'
    else
      @subjects = Subject.all
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

  def intermediate_attestation_params
    params.require(:intermediate_attestation).permit(:name, :date, :assessment_type, :subject_id)
  end
end
