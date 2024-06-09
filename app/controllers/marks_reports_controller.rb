class MarksReportsController < ApplicationController
  def new
    @record_books = RecordBook.all
    @grades = Grade.all
  end

  def create
    retake_count = params[:record_book_id].retake_count.to_i

    record_book_id = params[:record_book_id]

    pdf_data = MarksReport.generate_pdf(record_book_id, retake_count)

    send_data pdf_data, filename: 'marks_report.pdf', type: 'application/pdf'
  end
end
