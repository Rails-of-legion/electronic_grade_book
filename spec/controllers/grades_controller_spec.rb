# spec/controllers/grades_controller_spec.rb
require 'rails_helper'

RSpec.describe GradesController, type: :controller do
  let(:valid_attributes) {
    {
      record_book_id: create(:record_book).id, # Убедитесь, что атрибут существует
      grade: 90
    }
  }

  let(:invalid_attributes) {
    {
      record_book_id: nil, # Пример неверного значения
      grade: 90
    }
  }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Grade" do
        expect {
          post :create, params: { grade: valid_attributes }
        }.to change(Grade, :count).by(1)
      end

      it "redirects to the created grade" do
        post :create, params: { grade: valid_attributes }
        expect(response).to redirect_to(Grade.last)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'new' template)" do
        post :create, params: { grade: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    let(:grade) { create(:grade) }

    context "with valid parameters" do
      let(:new_attributes) {
        {
          record_book_id: create(:record_book).id,
          grade: 95
        }
      }

      it "updates the requested grade" do
        patch :update, params: { id: grade.id, grade: new_attributes }
        grade.reload
        expect(grade.grade).to eq(95)
      end

      it "redirects to the grade" do
        patch :update, params: { id: grade.id, grade: new_attributes }
        expect(response).to redirect_to(grade)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch :update, params: { id: grade.id, grade: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      grade = create(:grade)
      get :show, params: { id: grade.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #find" do
    it "returns a success response" do
      get :find, params: { record_book_id: create(:record_book).id }
      expect(response).to be_successful
    end
  end
end
