require 'rails_helper'

RSpec.describe IntermediateAttestationsController, type: :controller do
  let(:user) { create(:user, :as_admin) }
  let(:subject) { create(:subject) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:valid_attributes) { attributes_for(:intermediate_attestation, subject_id: subject.id, teacher_id: teacher.id) }
  let(:invalid_attributes) { attributes_for(:intermediate_attestation, name: nil) }
  let!(:intermediate_attestation) { create(:intermediate_attestation, subject: subject, teacher: teacher) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all intermediate_attestations as @intermediate_attestations' do
      get :index
      expect(assigns(:intermediate_attestations)).to include(intermediate_attestation)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested intermediate_attestation as @intermediate_attestation' do
      get :show, params: { id: intermediate_attestation.to_param }
      expect(assigns(:intermediate_attestation)).to eq(intermediate_attestation)
    end
  end

  describe 'GET #new' do
    it 'assigns a new intermediate_attestation as @intermediate_attestation' do
      get :new
      expect(assigns(:intermediate_attestation)).to be_a_new(IntermediateAttestation)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new IntermediateAttestation' do
        expect {
          post :create, params: { intermediate_attestation: valid_attributes }
        }.to change(IntermediateAttestation, :count).by(1)  # Должен увеличиться на 1
      end

      it 'assigns a newly created intermediate_attestation as @intermediate_attestation' do
        post :create, params: { intermediate_attestation: valid_attributes }
        expect(assigns(:intermediate_attestation)).to be_a(IntermediateAttestation)
        expect(assigns(:intermediate_attestation)).to be_persisted  # Проверка, что объект сохранен
      end

      it 'redirects to the created intermediate_attestation' do
        post :create, params: { intermediate_attestation: valid_attributes }
        expect(response).to redirect_to(IntermediateAttestation.last)  # Перенаправление на новый объект
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved intermediate_attestation as @intermediate_attestation' do
        post :create, params: { intermediate_attestation: invalid_attributes }
        expect(assigns(:intermediate_attestation)).to be_a_new(IntermediateAttestation)
      end

      it 're-renders the "new" template' do
        post :create, params: { intermediate_attestation: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: 'Updated Name' }
      }

      it 'updates the requested intermediate_attestation' do
        put :update, params: { id: intermediate_attestation.to_param, intermediate_attestation: new_attributes }
        intermediate_attestation.reload
        expect(intermediate_attestation.name).to eq('Updated Name')
      end

      it 'assigns the requested intermediate_attestation as @intermediate_attestation' do
        put :update, params: { id: intermediate_attestation.to_param, intermediate_attestation: valid_attributes }
        expect(assigns(:intermediate_attestation)).to eq(intermediate_attestation)
      end

      it 'redirects to the intermediate_attestation' do
        put :update, params: { id: intermediate_attestation.to_param, intermediate_attestation: valid_attributes }
        expect(response).to redirect_to(intermediate_attestation)
      end
    end

    context 'with invalid params' do
      it 'assigns the intermediate_attestation as @intermediate_attestation' do
        put :update, params: { id: intermediate_attestation.to_param, intermediate_attestation: invalid_attributes }
        expect(assigns(:intermediate_attestation)).to eq(intermediate_attestation)
      end

      it 're-renders the "edit" template' do
        put :update, params: { id: intermediate_attestation.to_param, intermediate_attestation: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested intermediate_attestation' do
      expect {
        delete :destroy, params: { id: intermediate_attestation.to_param }
      }.to change(IntermediateAttestation, :count).by(-1)
    end

    it 'redirects to the intermediate_attestations list' do
      delete :destroy, params: { id: intermediate_attestation.to_param }
      expect(response).to redirect_to(intermediate_attestations_url)
    end
  end
end
