require 'rails_helper'

RSpec.describe SubjectsRecordBooksController, type: :controller do
  let(:valid_attributes) { attributes_for(:subjects_record_book) }
  let(:invalid_attributes) { { subject_id: nil, record_book_id: nil } }
  let!(:subjects_record_book) { create(:subjects_record_book) }
  let(:user) { create(:user, :as_admin) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all subjects_record_books as @subjects_record_books' do
      get :index
      expect(assigns(:subjects_record_books)).to include(subjects_record_book)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested subjects_record_book as @subjects_record_book' do
      get :show, params: { id: subjects_record_book.to_param }
      expect(assigns(:subjects_record_book)).to eq(subjects_record_book)
    end
  end

  describe 'GET #new' do
    it 'assigns a new subjects_record_book as @subjects_record_book' do
      get :new
      expect(assigns(:subjects_record_book)).to be_a_new(SubjectsRecordBook)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested subjects_record_book as @subjects_record_book' do
      get :edit, params: { id: subjects_record_book.to_param }
      expect(assigns(:subjects_record_book)).to eq(subjects_record_book)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new SubjectsRecordBook' do
        expect {
          post :create, params: { subjects_record_book: valid_attributes }
        }.to change(SubjectsRecordBook, :count).by(1)
      end

      it 'assigns a newly created subjects_record_book as @subjects_record_book' do
        post :create, params: { subjects_record_book: valid_attributes }
        expect(assigns(:subjects_record_book)).to be_a(SubjectsRecordBook)
        expect(assigns(:subjects_record_book)).to be_persisted
      end

      it 'redirects to the created subjects_record_book' do
        post :create, params: { subjects_record_book: valid_attributes }
        expect(response).to redirect_to(SubjectsRecordBook.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved subjects_record_book as @subjects_record_book' do
        post :create, params: { subjects_record_book: invalid_attributes }
        expect(assigns(:subjects_record_book)).to be_a_new(SubjectsRecordBook)
      end

      it 're-renders the "new" template' do
        post :create, params: { subjects_record_book: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { subject_id: create(:subject).id }
      }

      it 'updates the requested subjects_record_book' do
        put :update, params: { id: subjects_record_book.to_param, subjects_record_book: new_attributes }
        subjects_record_book.reload
        expect(subjects_record_book.subject_id).to eq(new_attributes[:subject_id])
      end

      it 'assigns the requested subjects_record_book as @subjects_record_book' do
        put :update, params: { id: subjects_record_book.to_param, subjects_record_book: valid_attributes }
        expect(assigns(:subjects_record_book)).to eq(subjects_record_book)
      end

      it 'redirects to the subjects_record_book' do
        put :update, params: { id: subjects_record_book.to_param, subjects_record_book: valid_attributes }
        expect(response).to redirect_to(subjects_record_book)
      end
    end

    context 'with invalid params' do
      it 'assigns the subjects_record_book as @subjects_record_book' do
        put :update, params: { id: subjects_record_book.to_param, subjects_record_book: invalid_attributes }
        expect(assigns(:subjects_record_book)).to eq(subjects_record_book)
      end

      it 're-renders the "edit" template' do
        put :update, params: { id: subjects_record_book.to_param, subjects_record_book: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested subjects_record_book' do
      expect {
        delete :destroy, params: { id: subjects_record_book.to_param }
      }.to change(SubjectsRecordBook, :count).by(-1)
    end

    it 'redirects to the subjects_record_books list' do
      delete :destroy, params: { id: subjects_record_book.to_param }
      expect(response).to redirect_to(subjects_record_books_url)
    end
  end
end
