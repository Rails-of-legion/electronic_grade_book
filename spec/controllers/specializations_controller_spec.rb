require 'rails_helper'

RSpec.describe SpecializationsController, type: :controller do
  let!(:specialization) { create(:specialization) }
  let!(:subject) { create(:subject) }
  let(:valid_attributes) { { name: 'New Specialization', subject_ids: [subject.id] } }
  let(:invalid_attributes) { { name: '', subject_ids: [] } }

  let(:admin) { create(:user, :as_admin) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:student) { create(:user, :as_student) }

  describe 'GET #index' do
    context 'when admin is logged in' do
      before { sign_in admin }

      it 'assigns all specializations as @specializations' do
        get :index
        expect(assigns(:specializations)).to eq([specialization])
      end
    end

    context 'when teacher is logged in' do
      before { sign_in teacher }

      it 'assigns all specializations as @specializations' do
        get :index
        expect(assigns(:specializations)).to eq([specialization])
      end
    end

    context 'when student is logged in' do
      before { sign_in student }

      it 'redirects to root_path with an alert' do
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end
  describe 'GET #show' do
    context 'when admin is logged in' do
      before { sign_in admin }

      it 'assigns the requested specialization as @specialization' do
        get :show, params: { id: specialization.id }
        expect(assigns(:specialization)).to eq(specialization)
      end
    end

    context 'when teacher is logged in' do
      before { sign_in teacher }

      it 'assigns the requested specialization as @specialization' do
        get :show, params: { id: specialization.id }
        expect(assigns(:specialization)).to eq(specialization)
      end
    end

    context 'when student is logged in' do
      before { sign_in student }

      it 'redirects to root_path with an alert' do
        get :show, params: { id: specialization.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end
  describe 'GET #new' do
    context 'when admin is logged in' do
      before { sign_in admin }

      it 'assigns a new specialization as @specialization' do
        get :new
        expect(assigns(:specialization)).to be_a_new(Specialization)
      end
    end

    context 'when teacher is logged in' do
      before { sign_in teacher }

      it 'redirects to root_path with an alert' do
        get :new
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end

    context 'when student is logged in' do
      before { sign_in student }

      it 'redirects to root_path with an alert' do
        get :new
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end
  describe 'GET #edit' do
    context 'when admin is logged in' do
      before do
        sign_in admin
        get :edit, params: { id: specialization.id }
      end

      it 'assigns the requested specialization as @specialization' do
        expect(assigns(:specialization)).to eq(specialization)
      end

      it 'renders the :edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when teacher is logged in' do
      before do
        sign_in teacher
        get :edit, params: { id: specialization.id }
      end

      it 'redirects to root_path with an alert' do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end

    context 'when student is logged in' do
      before do
        sign_in student
        get :edit, params: { id: specialization.id }
      end

      it 'redirects to root_path with an alert' do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end
  describe 'POST #create' do
    context 'when admin is logged in' do
      before { sign_in admin }

      context 'with valid params' do
        it 'creates a new Specialization' do
          expect {
            post :create, params: { specialization: attributes_for(:specialization) }
          }.to change(Specialization, :count).by(1)
        end

        it 'assigns a newly created specialization as @specialization' do
          post :create, params: { specialization: attributes_for(:specialization) }
          expect(assigns(:specialization)).to be_a(Specialization)
          expect(assigns(:specialization)).to be_persisted
        end

        it 'redirects to the created specialization' do
          post :create, params: { specialization: attributes_for(:specialization) }
          expect(response).to render_template(:show)
        end
      end
    end

    context 'when teacher is logged in' do
      before { sign_in teacher }

      it 'redirects to root_path with an alert' do
        post :create, params: { specialization: attributes_for(:specialization) }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end

    context 'when student is logged in' do
      before { sign_in student }

      it 'redirects to root_path with an alert' do
        post :create, params: { specialization: attributes_for(:specialization) }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end
  describe 'PATCH/PUT #update' do
    let(:original_name) { specialization.name }

    context 'when admin is logged in' do
      before do
        sign_in admin
      end

      context 'with valid params' do
        let(:new_attributes) { { name: 'Updated Specialization' } }

        it 'updates the requested specialization' do
          patch :update, params: { id: specialization.id, specialization: new_attributes }
          specialization.reload
          expect(specialization.name).to eq('Updated Specialization')
        end

        it 'renders the :show template' do
          patch :update, params: { id: specialization.id, specialization: new_attributes }
          expect(response).to render_template(:show)
        end

        it 'sets a flash notice' do
          patch :update, params: { id: specialization.id, specialization: new_attributes }
          expect(flash[:notice]).to eq(I18n.t('questions.specialization_update_notice'))
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { { name: '' } }

        it 'does not update the specialization' do
          patch :update, params: { id: specialization.id, specialization: invalid_attributes }
          specialization.reload
          expect(specialization.name).to eq(original_name)
        end

        it 'renders the :edit template' do
          patch :update, params: { id: specialization.id, specialization: invalid_attributes }
          expect(response).to render_template(:edit)
        end

        it 'sets a flash alert' do
          patch :update, params: { id: specialization.id, specialization: invalid_attributes }
          expect(flash.now[:alert]).to eq(I18n.t('questions.specialization_update_alert'))
        end
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'when admin is logged in' do
      before do
        sign_in admin
      end

      it 'destroys the requested specialization' do
        expect {
          delete :destroy, params: { id: specialization.id }
        }.to change(Specialization, :count).by(-1)
      end

      it 'redirects to the specializations list' do
        delete :destroy, params: { id: specialization.id }
        expect(response).to redirect_to(specializations_url)
        expect(flash[:notice]).to eq(I18n.t('questions.specialization_destroy_notice'))
      end
    end

    context 'when teacher is logged in' do
      before do
        sign_in teacher
      end

      it 'redirects to root_path with an alert' do
        delete :destroy, params: { id: specialization.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end

    context 'when student is logged in' do
      before do
        sign_in student
      end

      it 'redirects to root_path with an alert' do
        delete :destroy, params: { id: specialization.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end
end
