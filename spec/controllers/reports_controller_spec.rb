require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe 'GET #generate_interim_report' do
    let(:teacher) { create(:user, role: :teacher) }
    let(:subject) { create(:subject) }
    let(:group) { create(:group) }
    let(:intermediate_attestation) { create(:intermediate_attestation, subject: subject, teacher: teacher) }
    let(:record_book) { create(:record_book, group: group) }
    let(:grade) { create(:grade, record_book: record_book, subject: subject, date: intermediate_attestation.date) }
    
    before do
      intermediate_attestation.groups << group
      record_book.grades << grade
      allow(controller).to receive(:send_file)
    end

    it 'assigns the requested intermediate_attestation' do
      get :generate_interim_report, params: { intermediate_attestation_id: intermediate_attestation.id }
      expect(assigns(:intermediate_attestation)).to eq(intermediate_attestation)
    end

    it 'generates a DOCX file' do
      expect(controller).to receive(:generate_interim_report_docx).with(intermediate_attestation).and_call_original
      get :generate_interim_report, params: { intermediate_attestation_id: intermediate_attestation.id }
    end

    it 'sends the generated DOCX file' do
      get :generate_interim_report, params: { intermediate_attestation_id: intermediate_attestation.id }
      expect(controller).to have_received(:send_file).with(anything, hash_including(filename: 'interim_report.docx', disposition: 'attachment'))
    end
  end
end
