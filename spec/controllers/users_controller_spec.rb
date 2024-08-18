require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, :as_admin) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:student) { create(:user, :as_student) }
  let(:user) { create(:user) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'assigns @q and @users' do
      get :index
      expect(assigns(:q)).to be_a(Ransack::Search)
      expect(assigns(:users)).to match_array([admin, teacher, student, user])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @user and @notificationsUser' do
      notification = create(:notification)
      create(:notifications_user, user: user, notification: notification)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(assigns(:notificationsUser)).to eq(user.notifications_users)
    end

    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user to @user' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the edit template' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the new user' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user' do
        expect {
          post :create, params: { user: attributes_for(:user, email: nil) }
        }.to_not change(User, :count)
      end

      it 're-renders the new template' do
        post :create, params: { user: attributes_for(:user, email: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the user' do
        patch :update, params: { id: user.id, user: { first_name: 'Updated' } }
        user.reload
        expect(user.first_name).to eq('Updated')
      end

      it 'redirects to the user' do
        patch :update, params: { id: user.id, user: { first_name: 'Updated' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: { email: nil } }
        user.reload
        expect(user.email).to_not be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: user.id, user: { email: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      user_to_delete = create(:user)
      expect {
        delete :destroy, params: { id: user_to_delete.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_path)
    end
  end

  describe 'GET #edit_password' do
    it 'renders the edit_password template' do
      get :edit_password, params: { id: user.id }
      expect(response).to render_template(:edit_password)
    end
  end

  describe 'PATCH #update_password' do
    context 'with valid attributes' do
      it 'updates the user password' do
        patch :update_password, params: { id: user.id, user: { password: 'newpassword', password_confirmation: 'newpassword' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the edit_password template' do
        patch :update_password, params: { id: user.id, user: { password: 'newpassword', password_confirmation: 'mismatch' } }
        expect(response).to render_template(:edit_password)
      end
    end
  end

  describe 'GET #edit_email' do
    it 'renders the edit_email template' do
      get :edit_email, params: { id: user.id }
      expect(response).to render_template(:edit_email)
    end
  end

  describe 'PATCH #update_email' do
    context 'with valid attributes' do
      it 'updates the user email' do
        patch :update_email, params: { id: user.id, user: { email: 'newemail@example.com' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the edit_email template' do
        patch :update_email, params: { id: user.id, user: { email: 'invalidemail' } }
        expect(response).to render_template(:edit_email)
      end
    end
  end
end
