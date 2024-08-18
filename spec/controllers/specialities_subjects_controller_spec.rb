require 'rails_helper'

RSpec.describe SpecialitiesSubjectsController, type: :controller do
  let!(:specialities_subject) { create(:specialities_subject) } # Предполагается, что у вас есть фабрика для SpecialitiesSubject

  describe 'GET #index' do
    it 'assigns @specialities_subjects and renders the index template' do
      get :index
      expect(assigns(:specialities_subjects)).to eq([specialities_subject])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested specialities_subject and renders the show template' do
      get :show, params: { id: specialities_subject.id }
      expect(assigns(:specialities_subject)).to eq(specialities_subject)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new specialities_subject and renders the new template' do
      get :new
      expect(assigns(:specialities_subject)).to be_a_new(SpecialitiesSubject)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested specialities_subject and renders the edit template' do
      get :edit, params: { id: specialities_subject.id }
      expect(assigns(:specialities_subject)).to eq(specialities_subject)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new specialities_subject and redirects to its show page' do
        expect {
          post :create, params: { specialities_subject: attributes_for(:specialities_subject) }
        }.to change(SpecialitiesSubject, :count).by(1)
        expect(response).to redirect_to(SpecialitiesSubject.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new specialities_subject and re-renders the new template' do
        expect {
          post :create, params: { specialities_subject: attributes_for(:specialities_subject, specialization_id: nil) }
        }.not_to change(SpecialitiesSubject, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the requested specialities_subject and redirects to its show page' do
        patch :update, params: { id: specialities_subject.id, specialities_subject: { specialization_id: new_value } }
        expect(specialities_subject.reload.specialization_id).to eq(new_value)
        expect(response).to redirect_to(specialities_subject)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the specialities_subject and re-renders the edit template' do
        patch :update, params: { id: specialities_subject.id, specialities_subject: { specialization_id: nil } }
        expect(specialities_subject.reload.specialization_id).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the specialities_subject and redirects to the index page' do
      expect {
        delete :destroy, params: { id: specialities_subject.id }
      }.to change(SpecialitiesSubject, :count).by(-1)
      expect(response).to redirect_to(specialities_subjects_url)
    end
  end
end
