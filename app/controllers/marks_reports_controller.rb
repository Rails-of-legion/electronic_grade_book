class MarksReportsController < ApplicationController
  def new
    @record_books = RecordBook.all
    @grades = Grade.all
  end

  def generate_report
    record_book_id = params[:record_book_id]
    retake_count = params[:retake_count].to_i

    pdf_data = MarksReport.generate_pdf(record_book_id, retake_count)

    send_data pdf_data, filename: 'marks_report.pdf', type: 'application/pdf', disposition: 'attachment'
  end
end
