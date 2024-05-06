class IndividualReportsController < ApplicationController
  def new
    @intermediate_attestations = IntermediateAttestation.all
    @record_books = RecordBook.all
  end
  def generate_report
    intermediate_attestation_id = params[:intermediate_attestation_id]
    record_book_id = params[:record_book_id]
    
    pdf_data = IndividualReport.generate_pdf(intermediate_attestation_id, record_book_id)

    send_data pdf_data, filename: "individual_report.pdf", type: "application/pdf"
  end
end
