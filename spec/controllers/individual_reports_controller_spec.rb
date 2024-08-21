require 'rails_helper'

RSpec.describe IndividualReportsController, type: :controller do
  let(:intermediate_attestation) { create(:intermediate_attestation) }
  let(:specialization) { create(:specialization) }
  let(:group) { create(:group) }
  let!(:record_book) { create(:record_book) }
  let(:user) { create(:user, :as_admin) }
  let(:teacher) { create(:user, :as_teacher) }
  
  before do
    sign_in user
    allow(RecordBook).to receive(:find).with(record_book.id.to_s).and_return(record_book)
    allow(IntermediateAttestation).to receive(:find).with(intermediate_attestation.id.to_s).and_return(intermediate_attestation)
  end

  describe 'GET #new' do
    it 'assigns to @intermediate_attestations, @record_books, @specializations, and @groups' do
      get :new
      expect(assigns(:intermediate_attestations)).to include(intermediate_attestation)
      expect(assigns(:record_books)).to include(record_book)
      expect(assigns(:specializations)).to include(specialization)
      expect(assigns(:groups)).to include(group)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #generate_report' do
    context 'when generating PDF report' do
      it 'calls IndividualReport.generate_pdf with correct arguments' do
        expect(IndividualReport).to receive(:generate_pdf).with(intermediate_attestation.id.to_s, record_book.id.to_s).and_return('pdf_data')

        get :generate_report, params: { intermediate_attestation_id: intermediate_attestation.id, record_book_id: record_book.id, format: :pdf }

        expect(response.header['Content-Type']).to include 'application/pdf'
        expect(response.body).to eq('pdf_data')
      end
    end

    context 'when generating DOCX report' do
      it 'calls IndividualReport.generate_docx with correct arguments' do
        expect(IndividualReport).to receive(:generate_docx).with(intermediate_attestation.id.to_s, record_book.id.to_s).and_return('docx_data')

        get :generate_report, params: { intermediate_attestation_id: intermediate_attestation.id, record_book_id: record_book.id, format: :docx }

        expect(response.header['Content-Type']).to include 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        expect(response.body).to eq('docx_data')
      end
    end
  end
end
