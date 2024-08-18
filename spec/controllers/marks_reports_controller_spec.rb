# spec/controllers/marks_reports_controller_spec.rb

require 'rails_helper'

RSpec.describe MarksReportsController, type: :controller do
  let!(:record_book) { create(:record_book) }
  let!(:grades) { create_list(:grade, 5, record_book: record_book) }

  describe 'GET #new' do
    before { get :new }

    it 'assigns @record_books' do
      expect(assigns(:record_books)).to eq([record_book])
    end

    it 'assigns @grades' do
      expect(assigns(:grades)).to eq(grades)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #generate_report' do
    let(:retake_count) { 2 }

    before do
      allow(RecordBook).to receive(:find).and_return(record_book)
      allow(record_book.grades).to receive(:where).with(is_retake: true).and_return(grades.first(retake_count))
    end

    context 'when format is PDF' do
      it 'returns a PDF file' do
        post :generate_report, params: { record_book_id: record_book.id }, format: :pdf

        expect(response.content_type).to eq('application/pdf')
        expect(response.header['Content-Disposition']).to include('attachment')
        expect(response.body).to start_with('%PDF')
      end
    end

    context 'when format is DOCX' do
      it 'returns a DOCX file' do
        post :generate_report, params: { record_book_id: record_book.id }, format: :docx

        expect(response.content_type).to eq('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
        expect(response.header['Content-Disposition']).to include('attachment')
        expect(response.body).start_with('<?xml')  # Check for XML declaration in DOCX files
      end
    end
  end
end
