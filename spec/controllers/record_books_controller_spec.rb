require 'rails_helper'

RSpec.describe RecordBooksController, type: :controller do
  let(:user) { create(:user, :as_student) }
  let(:admin) { create(:user, :as_admin) }
  let(:group) { create(:group) }
  let(:specialization) { create(:specialization) }
  let(:record_book) { create(:record_book, user: user, specialization: specialization, group: group) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "assigns @record_books and renders the index template" do
      get :index
      expect(assigns(:record_books)).to include(record_book)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns @grades and @subjects based on the selected month" do
      grade = create(:grade, record_book: record_book, date: Date.new(2024, 8, 1))
      subject = create(:subject, specializations: [specialization])
      get :show, params: { id: record_book.id, month: 8 }
      
      expect(assigns(:grades)).to include(grade)
      expect(assigns(:subjects)).to include(subject)
      expect(response).to render_template(:show)
    end

    it "defaults to the current month if no month is provided" do
      grade = create(:grade, record_book: record_book, date: Time.zone.today)
      subject = create(:subject, specializations: [specialization])
      get :show, params: { id: record_book.id }

      expect(assigns(:grades)).to include(grade)
      expect(assigns(:subjects)).to include(subject)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new @record_book and renders the new template" do
      get :new
      expect(assigns(:record_book)).to be_a_new(RecordBook)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "renders the edit template for the selected record book" do
      get :edit, params: { id: record_book.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
      it "authorizes the creation of the record book" do
      allow(controller).to receive(:authorize!).with(:create, instance_of(RecordBook))
      post :create, params: { record_book: attributes_for(:record_book, user_id: user.id, specialization_id: specialization.id, group_id: group.id) }
      expect(controller).to have_received(:authorize!).with(:create, instance_of(RecordBook)).at_least(:once)
    end
    

    context "with invalid attributes" do
      it "does not save the new record book and re-renders the new template" do
        post :create, params: { record_book: attributes_for(:record_book, user_id: nil) }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    let(:updated_attributes) { { custom_number: "Updated Number" } }

    it "authorizes the update of the record book" do
      allow(controller).to receive(:authorize!).with(:update, record_book)
      patch :update, params: { id: record_book.id, record_book: updated_attributes }
      expect(controller).to have_received(:authorize!).with(:update, record_book).at_least(:once)
    end

    context "with valid attributes" do
      it "updates the record book and redirects to the record book's page with a success notice" do
        patch :update, params: { id: record_book.id, record_book: updated_attributes }
        record_book.reload
        expect(record_book.custom_number).to eq("Updated Number")
        expect(response).to redirect_to(record_book)
        expect(flash[:notice]).to eq(I18n.t('questions.record_books_update_notice'))
      end
    end

    context "with invalid attributes" do
      it "does not update the record book and re-renders the edit template with an error status" do
        patch :update, params: { id: record_book.id, record_book: { custom_number: nil } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "authorizes the destruction of the record book" do
      allow(controller).to receive(:authorize!).with(:destroy, record_book)
      delete :destroy, params: { id: record_book.id }
      expect(controller).to have_received(:authorize!).with(:destroy, record_book).at_least(:once)
    end

    it "destroys the record book and redirects to the index page with a success notice" do
      expect {
        delete :destroy, params: { id: record_book.id }
      }.to change(RecordBook, :count).by(0)
      expect(response).to redirect_to(record_books_path)
      expect(flash[:notice]).to eq(I18n.t('questions.record_books_destroy_notice'))
    end
  end
end
