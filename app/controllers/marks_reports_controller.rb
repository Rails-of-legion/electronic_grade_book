class MarksReportsController < ApplicationController
  def new
    @record_books = RecordBook.all
    @grades = Grade.all
  end

  def generate_report
    record_book_id = params[:record_book_id]
    retake_count = RecordBook.find(record_book_id).grades.where(is_retake: true).count

    respond_to do |format|
      format.pdf do
        pdf_data = MarksReport.generate_pdf(record_book_id, retake_count)
        send_data pdf_data, filename: 'marks_report.pdf', type: 'application/pdf', disposition: 'attachment'
      end
      format.docx do
        docx_data = MarksReport.generate_docx(record_book_id, retake_count)
        send_data docx_data, filename: 'marks_report.docx', type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', disposition: 'attachment'
      end
    end
  end
end
