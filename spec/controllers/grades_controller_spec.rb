require 'rails_helper'

RSpec.describe GradesController, type: :controller do
  let(:admin) { create(:user, :as_admin) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:student) { create(:user, :as_student) }
  let!(:grade) { create(:grade, grade: 2) }
  let!(:record_book) { create(:record_book) }
  let!(:subject) { create(:subject) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "assigns @grades and renders the index template" do
      get :index
      expect(assigns(:grades)).to include(grade)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: grade.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) do
        {
          grade: 8,
          date: "2024-08-22",
          subject_id: subject.id,
          record_book_id: record_book.id
        }
      end

      it "creates a new Grade" do
        expect {
          post :create, params: { grade: valid_attributes }
        }.to change(Grade, :count).by(1)
      end

      it "redirects to the created grade" do
        post :create, params: { grade: valid_attributes }
        expect(response).to redirect_to(Grade.last)
        expect(flash[:notice]).to eq(I18n.t('questions.grades_create_notice'))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) do
        { grade: nil }
      end
  
      it "does not create a new Grade" do
        expect {
          post :create, params: { grade: invalid_attributes }
        }.to_not change(Grade, :count)
      end
  
      it "renders the new template with errors" do
        post :create, params: { grade: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { grade: 5 }
      end

      it "updates the requested grade" do
        patch :update, params: { id: grade.id, grade: new_attributes }
        grade.reload
        expect(grade.grade).to eq(5)
      end

      it "redirects to the grade" do
        patch :update, params: { id: grade.id, grade: new_attributes }
        expect(response).to redirect_to(grade)
        expect(flash[:notice]).to eq(I18n.t('questions.grades_update_notice'))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) do
        { grade: nil }
      end

      it "does not update the grade" do
        patch :update, params: { id: grade.id, grade: invalid_attributes }
        grade.reload
        expect(grade.grade).to eq(2)
      end

      it "renders the edit template with errors" do
        patch :update, params: { id: grade.id, grade: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:grade_to_delete) { create(:grade) }

    it "destroys the requested grade" do
      expect {
        delete :destroy, params: { id: grade_to_delete.id }
      }.to change(Grade, :count).by(-1)
    end

    it "redirects to the grades index" do
      delete :destroy, params: { id: grade.id }
      expect(response).to redirect_to(grade_url)
    end
  end

  describe "GET #find" do
    it "returns the grade matching the given parameters" do
      get :find, params: { date: grade.date.to_s, subject_id: grade.subject_id, record_book_id: grade.record_book_id }
      expect(response).to be_successful
      expect(JSON.parse(response.body)['id']).to eq(grade.id)
    end
  end
end
