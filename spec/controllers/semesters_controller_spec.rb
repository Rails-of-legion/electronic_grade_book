require 'rails_helper'

RSpec.describe SemestersController, type: :controller do
  let(:admin) { create(:user, :as_admin) }
  let(:semester) { create(:semester) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'assigns @q and @semesters' do
      get :index
      expect(assigns(:q)).to be_a(Ransack::Search)
      expect(assigns(:semesters)).to eq([semester])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested semester to @semester' do
      get :show, params: { id: semester.id }
      expect(assigns(:semester)).to eq(semester)
    end

    it 'renders the :show template' do
      get :show, params: { id: semester.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new semester to @semester' do
      get :new
      expect(assigns(:semester)).to be_a_new(Semester)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested semester to @semester' do
      get :edit, params: { id: semester.id }
      expect(assigns(:semester)).to eq(semester)
    end

    it 'renders the :edit template' do
      get :edit, params: { id: semester.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new semester' do
        expect {
          post :create, params: { semester: attributes_for(:semester) }
        }.to change(Semester, :count).by(1)
      end

      it 'redirects to the new semester' do
        post :create, params: { semester: attributes_for(:semester) }
        expect(response).to redirect_to(Semester.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new semester' do
        expect {
          post :create, params: { semester: attributes_for(:semester, name: nil) }
        }.to_not change(Semester, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { semester: attributes_for(:semester, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the semester' do
        patch :update, params: { id: semester.id, semester: { name: 'Updated Name' } }
        semester.reload
        expect(semester.name).to eq('Updated Name')
      end

      it 'redirects to the updated semester' do
        patch :update, params: { id: semester.id, semester: { name: 'Updated Name' } }
        expect(response).to redirect_to(semester)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the semester' do
        patch :update, params: { id: semester.id, semester: { name: nil } }
        expect(semester.name).to_not be_nil
      end

      it 're-renders the :edit template' do
        patch :update, params: { id: semester.id, semester: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the semester' do
      semester
      expect {
        delete :destroy, params: { id: semester.id }
      }.to change(Semester, :count).by(-1)
    end

    it 'redirects to semesters#index' do
      delete :destroy, params: { id: semester.id }
      expect(response).to redirect_to(semesters_url)
    end
  end
end
