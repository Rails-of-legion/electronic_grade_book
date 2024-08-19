# spec/controllers/groups_controller_spec.rb
require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:admin) { create(:user, :as_admin) }
  let(:group) { create(:group) }
  
  before do
    sign_in admin
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns @groups" do
      get :index
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: group.id }
      expect(response).to be_successful
    end

    it "assigns @group" do
      get :show, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
    end

    it "assigns @subjects" do
      get :show, params: { id: group.id }
      expect(assigns(:subjects)).to eq(group.specialization.subjects)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Group" do
        expect {
          post :create, params: { group: attributes_for(:group) }
        }.to change(Group, :count).by(0)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { group: attributes_for(:group, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "New Group Name" } }

      it "updates the requested group" do
        put :update, params: { id: group.id, group: new_attributes }
        group.reload
        expect(group.name).to eq("New Group Name")
      end

      it "redirects to the group" do
        put :update, params: { id: group.id, group: new_attributes }
        expect(response).to redirect_to(group)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: group.id, group: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested group" do
      group # to create the group before the expect block
      expect {
        delete :destroy, params: { id: group.id }
      }.to change(Group, :count).by(-1)
    end

    it "redirects to the groups list" do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(groups_url)
    end
  end

  describe "GET #form_teacher" do
    it "returns a success response" do
      get :form_teacher, params: { group_id: group.id, month: 5 }
      expect(response).to be_successful
    end
  end
end
