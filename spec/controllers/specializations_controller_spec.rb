require 'rails_helper'

RSpec.describe SpecializationsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Test Specialization' }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  let(:valid_session) { {} }



  describe "GET #show" do
    it "returns a success response" do
      specialization = Specialization.create!(valid_attributes)
      get :show, params: { id: specialization.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      specialization = Specialization.create!(valid_attributes)
      get :edit, params: { id: specialization.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Specialization" do
        expect {
          post :create, params: { specialization: valid_attributes }, session: valid_session
        }.to change(Specialization, :count).by(1)
      end

      it "redirects to the created specialization" do
        post :create, params: { specialization: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Specialization.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { specialization: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    let(:new_attributes) {
      { name: 'New Specialization' }
    }

    context "with valid params" do
      it "updates the requested specialization" do
        specialization = Specialization.create!(valid_attributes)
        patch :update, params: { id: specialization.to_param, specialization: new_attributes }, session: valid_session
        specialization.reload
        expect(specialization.name).to eq('New Specialization')
      end

      it "redirects to the specialization" do
        specialization = Specialization.create!(valid_attributes)
        patch :update, params: { id: specialization.to_param, specialization: valid_attributes }, session: valid_session
        expect(response).to redirect_to(specialization)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        specialization = Specialization.create!(valid_attributes)
        patch :update, params: { id: specialization.to_param, specialization: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested specialization" do
      specialization = Specialization.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: specialization.to_param }, session: valid_session
      }.to change(Specialization, :count).by(-1)
    end

    it "redirects to the specializations list" do
      specialization = Specialization.create!(valid_attributes)
      delete :destroy, params: { id: specialization.to_param }, session: valid_session
      expect(response).to redirect_to(specializations_url)
    end
  end
end
