require 'rails_helper'

RSpec.describe AttestationRetakeReportsController, type: :controller do
  let(:user) { create(:user, :as_admin) }
  let(:subject) { create(:subject) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:intermediate_attestation) { create(:intermediate_attestation, subject: subject, teacher: teacher) }
  let(:group) { create(:group) }
  let(:record_book) { create(:record_book, group: group, intermediate_attestation: intermediate_attestation, student: create(:user, :as_student)) }
  let(:grade) { create(:grade, record_book: record_book) }
  let(:params) { { exam_id: intermediate_attestation.id, group_id: group.id } }

  before do
    sign_in user
  end

  describe 'GET #select' do
    it 'assigns @attestations and @groups' do
      get :select
      expect(assigns(:attestations)).to eq([intermediate_attestation])
      expect(assigns(:groups)).to eq([group])
    end

    it 'renders the :select template' do
      get :select
      expect(response).to render_template(:select)
    end
  end

  describe 'POST #generate_report' do

    it 'renders PDF format' do
      post :generate_report, params: params, format: :pdf
      expect(response.content_type).to eq('application/pdf')
      expect(response.headers['Content-Disposition']).to include('attachment')
    end

    it 'renders DOCX format' do
      post :generate_report, params: params, format: :docx
      expect(response.content_type).to eq('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
      expect(response.headers['Content-Disposition']).to include('attachment')
    end
  end
end