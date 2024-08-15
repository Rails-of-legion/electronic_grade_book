require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user1) { create(:user, :as_student) }
  let(:user2) { create(:user, :as_teacher) }
  let(:user3) { create(:user, :as_admin) }
  let(:notification) { create(:notification) }
  let(:valid_attributes) { attributes_for(:notification, user_ids: [user1.id]) }
  let(:invalid_attributes) { attributes_for(:notification, message: nil) }
  let!(:notification_user) { create(:notifications_user, notification: notification, user: user1, status: false) }

  before do
    sign_in user1
  end

  describe "GET #index" do
    it "assigns @notifications and renders the index template" do
      get :index
      expect(assigns(:notifications)).to include(notification)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested notification as @notification" do
      get :show, params: { id: notification.to_param }
      expect(assigns(:notification)).to eq(notification)
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
      get :edit, params: { id: notification.to_param }
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

      it "creates new NotificationsUser records only if they do not exist" do
        expect {
          post :create, params: { notification: valid_attributes }
        }.to change(NotificationsUser, :count).by(1)

        expect {
          post :create, params: { notification: valid_attributes }
        }.to change(Notification, :count).by(1)

        expect(NotificationsUser.where(notification: Notification.last, user_id: valid_attributes[:user_ids].first)).to exist
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
        }.not_to change(Notification, :count)
      end

      it "does not create any NotificationsUser records" do
        expect {
          post :create, params: { notification: invalid_attributes }
        }.not_to change(NotificationsUser, :count)
      end

      it "assigns a newly created but unsaved notification as @notification" do
        post :create, params: { notification: invalid_attributes }
        expect(assigns(:notification)).to be_a_new(Notification)
      end

      it "re-renders the 'new' template" do
        post :create, params: { notification: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { message: "Updated message" } }

      it "updates the requested notification" do
        put :update, params: { id: notification.to_param, notification: new_attributes }
        notification.reload
        expect(notification.message).to eq("Updated message")
      end

      it "assigns the requested notification as @notification" do
        put :update, params: { id: notification.to_param, notification: valid_attributes }
        expect(assigns(:notification)).to eq(notification)
      end

      it "redirects to the notification" do
        put :update, params: { id: notification.to_param, notification: valid_attributes }
        expect(response).to redirect_to(notification)
      end
    end

    context "with invalid params" do
      it "does not update the notification" do
        put :update, params: { id: notification.to_param, notification: invalid_attributes }
        expect(notification.reload.message).not_to be_nil
      end

      it "assigns the notification as @notification" do
        put :update, params: { id: notification.to_param, notification: invalid_attributes }
        expect(assigns(:notification)).to eq(notification)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: notification.to_param, notification: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested notification" do
      notification_to_delete = create(:notification)
      expect {
        delete :destroy, params: { id: notification_to_delete.to_param }
      }.to change(Notification, :count).by(-1)
    end

    it "redirects to the notifications list" do
      delete :destroy, params: { id: notification.to_param }
      expect(response).to redirect_to(notifications_url)
    end
  end

  describe "PATCH #mark_as_read" do
    context "when the NotificationsUser record exists" do
      it "marks the notification as read" do
        patch :mark_as_read, params: { id: notification.id }
        notification_user.reload
        expect(notification_user.status).to be true
      end

      it "redirects to the user's page with a success notice" do
        patch :mark_as_read, params: { id: notification.id }
        expect(response).to redirect_to(user_path(user1))
        expect(flash[:notice]).to eq(I18n.t('questions.notifications_mark_as_read_notice'))
      end
    end

    context "when the NotificationsUser record does not exist" do
      before do
        NotificationsUser.where(notification: notification, user: user1).destroy_all
      end

      it "redirects to the notifications path with an alert" do
        patch :mark_as_read, params: { id: notification.id }
        expect(response).to redirect_to(notifications_path)
        expect(flash[:alert]).to eq(I18n.t('questions.notifications_mark_as_read_alert'))
      end
    end
  end
end
