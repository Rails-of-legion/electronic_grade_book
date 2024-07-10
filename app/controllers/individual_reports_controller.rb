class IndividualReportsController < ApplicationController
  def new
    @intermediate_attestations = IntermediateAttestation.all
    @record_books = RecordBook.all
    @specializations = Specialization.all
    @groups = Group.all
  end

  def generate_report
    intermediate_attestation_id = params[:intermediate_attestation_id]
    record_book_id = params[:record_book_id]

     respond_to do |format|
      format.pdf do
        pdf_data = IndividualReport.generate_pdf(intermediate_attestation_id, record_book_id)
        send_data pdf_data, filename: 'individual_report.pdf', type: 'application/pdf'
      end

      format.docx do
        docx_data = IndividualReport.generate_docx(intermediate_attestation_id, record_book_id)
        send_data docx_data, filename: 'individual_report.docx', type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      end
    end
  end
end
