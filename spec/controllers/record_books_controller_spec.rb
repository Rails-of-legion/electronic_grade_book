require 'rails_helper'

RSpec.describe RecordBooksController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:record_book) { create(:record_book) }

  before do
    sign_in(admin)
  end

  describe "GET #index" do
    it "assigns @record_books and @total_record_books" do
      record_books = create_list(:record_book, 3)
      get :index
      expect(assigns(:record_books)).to match_array(record_books)
      expect(assigns(:total_record_books)).to eq(record_books.count)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "filters by group_id when group_id is present" do
      group = create(:group)
      record_book_in_group = create(:record_book, group: group)
      record_book_outside_group = create(:record_book)

      get :index, params: { group_id: group.id }
      expect(assigns(:record_books)).to include(record_book_in_group)
      expect(assigns(:record_books)).not_to include(record_book_outside_group)
    end
  end

  describe "GET #show" do
    it "assigns the requested record_book to @record_book" do
      get :show, params: { id: record_book.id }
      expect(assigns(:record_book)).to eq(record_book)
    end

    it "assigns grades and subjects" do
      get :show, params: { id: record_book.id, month: 5 }
      expect(assigns(:grades)).to eq(record_book.grades.where("extract(month from date) = ?", 5))
      expect(assigns(:subjects)).to eq(record_book.specialization.subjects)
    end

    it "renders the :show template" do
      get :show, params: { id: record_book.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new record_book to @record_book" do
      get :new
      expect(assigns(:record_book)).to be_a_new(RecordBook)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "assigns the requested record_book to @record_book" do
      get :edit, params: { id: record_book.id }
      expect(assigns(:record_book)).to eq(record_book)
    end

    it "renders the :edit template" do
      get :edit, params: { id: record_book.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new record_book" do
        expect {
          post :create, params: { record_book: attributes_for(:record_book) }
        }.to change(RecordBook, :count).by(1)
      end

      it "redirects to the created record_book" do
        post :create, params: { record_book: attributes_for(:record_book) }
        expect(response).to redirect_to(RecordBook.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new record_book" do
        expect {
          post :create, params: { record_book: attributes_for(:record_book, user_id: nil) }
        }.not_to change(RecordBook, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { record_book: attributes_for(:record_book, user_id: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the record_book" do
        patch :update, params: { id: record_book.id, record_book: { custom_number: '12345' } }
        record_book.reload
        expect(record_book.custom_number).to eq('12345')
      end

      it "redirects to the updated record_book" do
        patch :update, params: { id: record_book.id, record_book: { custom_number: '12345' } }
        expect(response).to redirect_to(record_book)
      end
    end

    context "with invalid attributes" do
      it "does not change the record_book" do
        patch :update, params: { id: record_book.id, record_book: { user_id: nil } }
        record_book.reload
        expect(record_book.user_id).not_to be_nil
      end

      it "re-renders the :edit template" do
        patch :update, params: { id: record_book.id, record_book: { user_id: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the record_book" do
      record_book = create(:record_book)
      expect {
        delete :destroy, params: { id: record_book.id }
      }.to change(RecordBook, :count).by(-1)
    end

    it "redirects to record_books#index" do
      delete :destroy, params: { id: record_book.id }
      expect(response).to redirect_to(record_books_path)
    end
  end
end
