require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) { create(:notification) }
  let(:valid_attributes) { attributes_for(:notification, user_ids: [user.id]) }
  let(:invalid_attributes) { attributes_for(:notification, message: nil) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "assigns all notifications as @notifications" do
      get :index
      expect(assigns(:notifications)).to eq([notification])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested notification as @notification" do
      get :show, params: { id: notification.id }
      expect(assigns(:notification)).to eq(notification)
    end

    it "renders the show template" do
      get :show, params: { id: notification.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new notification as @notification" do
      get :new
      expect(assigns(:notification)).to be_a_new(Notification)
    end
  end

  describe "GET #edit" do
    it "assigns the requested notification as @notification" do
      get :edit, params: { id: notification.id }
      expect(assigns(:notification)).to eq(notification)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Notification" do
        expect {
          post :create, params: { notification: valid_attributes }
        }.to change(Notification, :count).by(1)
      end

      it "assigns a newly created notification as @notification" do
        post :create, params: { notification: valid_attributes }
        expect(assigns(:notification)).to be_a(Notification)
        expect(assigns(:notification)).to be_persisted
      end

      it "redirects to the created notification" do
        post :create, params: { notification: valid_attributes }
        expect(response).to redirect_to(Notification.last)
      end
    end

    context "with invalid params" do
      it "does not create a new Notification" do
        expect {
          post :create, params: { notification: invalid_attributes }
        }.to change(Notification, :count).by(0)
      end

      it "assigns a newly created but unsaved notification as @notification" do
        post :create, params: { notification: invalid_attributes }
        expect(assigns(:notification)).to be_a_new(Notification)
      end

      it "re-renders the 'new' template" do
        post :create, params: { notification: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { message: 'Updated Message' } }

      it "updates the requested notification" do
        put :update, params: { id: notification.id, notification: new_attributes }
        notification.reload
        expect(notification.message).to eq('Updated Message')
      end

      it "redirects to the notification" do
        put :update, params: { id: notification.id, notification: valid_attributes }
        expect(response).to redirect_to(notification)
      end
    end

    context "with invalid params" do
      it "assigns the notification as @notification" do
        put :update, params: { id: notification.id, notification: invalid_attributes }
        expect(assigns(:notification)).to eq(notification)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: notification.id, notification: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested notification" do
      notification_to_destroy = create(:notification)
      expect {
        delete :destroy, params: { id: notification_to_destroy.id }
      }.to change(Notification, :count).by(-1)
    end

    it "redirects to the notifications list" do
      delete :destroy, params: { id: notification.id }
      expect(response).to redirect_to(notifications_url)
    end
  end

  describe "POST #mark_as_read" do
    it "marks the notification as read" do
      notification_user = create(:notifications_user, notification: notification, user: user)
      post :mark_as_read, params: { id: notification.id }
      notification_user.reload
      expect(notification_user.status).to be_truthy
    end

    it "redirects to the user's profile" do
      create(:notifications_user, notification: notification, user: user)
      post :mark_as_read, params: { id: notification.id }
      expect(response).to redirect_to(user_path(user))
    end
  end
end
