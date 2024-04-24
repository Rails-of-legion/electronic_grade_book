class RecordBooksIntermediateAttestationsController < ApplicationController
  before_action :set_record_books_intermediate_attestation, only: %i[show edit update destroy]

  def index
    @record_books_intermediate_attestations = RecordBooksIntermediateAttestation.all
  end

  def show; end

  def new
    @record_books_intermediate_attestation = RecordBooksIntermediateAttestation.new
  end

  def edit; end

  def create
    @record_books_intermediate_attestation = RecordBooksIntermediateAttestation.new(record_books_intermediate_attestation_params)

    if @record_books_intermediate_attestation.save
      redirect_to @record_books_intermediate_attestation,
                  notice: 'Record Books Intermediate Attestation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @record_books_intermediate_attestation.update(record_books_intermediate_attestation_params)
      redirect_to @record_books_intermediate_attestation,
                  notice: 'Record Books Intermediate Attestation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @record_books_intermediate_attestation.destroy
    redirect_to record_books_intermediate_attestations_url,
                notice: 'Record Books Intermediate Attestation was successfully destroyed.'
  end

  private

  def set_record_books_intermediate_attestation
    @record_books_intermediate_attestation = RecordBooksIntermediateAttestation.find(params[:id])
  end

  def record_books_intermediate_attestation_params
    params.require(:record_books_intermediate_attestation).permit(:record_book_id, :intermediate_attestation_id)
  end
end
