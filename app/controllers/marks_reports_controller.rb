class MarksReportsController < ApplicationController
  def new
    @record_books = RecordBook.all
    @grades = Grade.all
  end

  def generate_report
    record_book_id = params[:record_book_id]
    retake_count = RecordBook.find(record_book_id).grades.where(is_retake: true).count

    pdf_data = MarksReport.generate_pdf(record_book_id, retake_count)

    send_data pdf_data, filename: 'marks_report.pdf', type: 'application/pdf', disposition: 'attachment'
  end
end
