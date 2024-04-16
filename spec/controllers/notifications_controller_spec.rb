require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:valid_attributes) {
    { message: 'Test message', date: Date.today, read_status: false }
  }

  let(:invalid_attributes) {
    { message: '', date: nil, read_status: nil }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Notification.create!(valid_attributes)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      notification = Notification.create!(valid_attributes)
      get :show, params: { id: notification.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Notification" do
        expect {
          post :create, params: { notification: valid_attributes }, session: valid_session
        }.to change(Notification, :count).by(1)
      end

      it "redirects to the created notification" do
        post :create, params: { notification: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Notification.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { notification: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        { message: 'New message' }
      }

      it "updates the requested notification" do
        notification = Notification.create!(valid_attributes)
        patch :update, params: { id: notification.to_param, notification: new_attributes }, session: valid_session
        notification.reload
        expect(notification.message).to eq('New message')
      end

      it "redirects to the notification" do
        notification = Notification.create!(valid_attributes)
        patch :update, params: { id: notification.to_param, notification: valid_attributes }, session: valid_session
        expect(response).to redirect_to(notification)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        notification = Notification.create!(valid_attributes)
        patch :update, params: { id: notification.to_param, notification: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested notification" do
      notification = Notification.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: notification.to_param }, session: valid_session
      }.to change(Notification, :count).by(-1)
    end

    it "redirects to the notifications list" do
      notification = Notification.create!(valid_attributes)
      delete :destroy, params: { id: notification.to_param }, session: valid_session
      expect(response).to redirect_to(notifications_url)
    end
  end
end
