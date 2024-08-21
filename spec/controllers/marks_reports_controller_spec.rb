require 'rails_helper'

RSpec.describe MarksReportsController, type: :controller do
  let(:user) { create(:user, :as_admin) }
  let(:subject) { create(:subject) }
  let(:teacher) { create(:user, :as_teacher) }
  let!(:record_book) { create(:record_book) }
  let!(:grade) { create(:grade, record_book: record_book) }
  let(:retake_count) { 0 }

  before do
    sign_in user
    allow(RecordBook).to receive(:find).with(record_book.id.to_s).and_return(record_book)
    allow(record_book.grades.where(is_retake: true)).to receive(:count).and_return(retake_count)
  end

  describe 'GET #new' do
    it 'assigns to @record_books and @grades' do
      get :new
      expect(assigns(:record_books)).to eq([record_book])
      expect(assigns(:grades)).to eq([grade])
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #generate_report' do
    context 'when generating PDF report' do
      it 'calls MarksReport.generate_pdf with correct arguments' do
        expect(MarksReport).to receive(:generate_pdf).with(record_book.id.to_s, retake_count).and_return('pdf_data')

        get :generate_report, params: { record_book_id: record_book.id, format: :pdf }

        expect(response.header['Content-Type']).to include 'application/pdf'
        expect(response.header['Content-Disposition']).to include 'attachment'
        expect(response.body).to eq('pdf_data')
      end
    end

    context 'when generating DOCX report' do
      it 'calls MarksReport.generate_docx with correct arguments' do
        expect(MarksReport).to receive(:generate_docx).with(record_book.id.to_s, retake_count).and_return('docx_data')

        get :generate_report, params: { record_book_id: record_book.id, format: :docx }

        expect(response.header['Content-Type']).to include 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        expect(response.header['Content-Disposition']).to include 'attachment'
        expect(response.body).to eq('docx_data')
      end
    end
  end
end
