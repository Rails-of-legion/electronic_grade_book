require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user) { create(:user, :as_student) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #search' do
    it 'renders the search template' do
      get :search
      expect(response).to render_template(:search)
    end
  end

  describe 'GET #search' do
    it 'renders the search template' do
      get :search
      expect(response).to render_template(:search)
    end
  end

  describe 'POST #find_user' do
    let(:params) do
      {
        user: {
          first_name: user.first_name,
          last_name: user.last_name,
          middle_name: user.middle_name,
          phone_number: user.phone_number,
          'date_of_birth(1i)' => user.date_of_birth.year,
          'date_of_birth(2i)' => user.date_of_birth.month,
          'date_of_birth(3i)' => user.date_of_birth.day
        }
      }
    end

    context 'when user is found' do
      it 'assigns @user' do
        post :find_user, params: params
        expect(assigns(:user)).to eq(user)
      end

      context 'and user status is not blank' do
        it 'redirects to users_search_path with alert' do
          post :find_user, params: params
          expect(response).to redirect_to(users_search_path)
          expect(flash[:alert]).to eq(I18n.t('questions.register_alert'))
        end
      end
    end

    context 'when user is not found' do
      let(:params) do
        {
          user: {
            first_name: 'Nonexistent',
            last_name: 'User',
            middle_name: 'Unknown',
            phone_number: '1234567890',
            'date_of_birth(1i)' => 2000,
            'date_of_birth(2i)' => 1,
            'date_of_birth(3i)' => 1
          }
        }
      end

      it 'redirects to users_search_path with alert' do
        post :find_user, params: params
        expect(response).to redirect_to(users_search_path)
        expect(flash[:alert]).to eq(I18n.t('questions.register_alert'))
      end
    end
  end

  describe 'POST #set_password_and_email' do
    let(:user) { create(:user, :as_student) }
    let(:params) do
      { user: { id: user.id, email: 'new_email@example.com', password: 'newpassword', password_confirmation: 'newpassword' } }
    end
    
    context 'when update is successful' do
      it 'updates user status to true' do
        post :set_password_and_email, params: params
        expect(user.reload.status).to be_truthy
      end

      it 'sends a registration confirmation email' do
        expect {
          post :set_password_and_email, params: params
        }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end

      it 'signs in the user and redirects to root path with notice' do
        post :set_password_and_email, params: params
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t('questions.register_notice'))
      end
    end

    context 'when update fails' do
      before do
        allow_any_instance_of(User).to receive(:update).and_return(false)
      end

      it 'renders the set_password_and_email template when update fails' do
        allow_any_instance_of(User).to receive(:update).and_return(false)
        post :set_password_and_email, params: params
        expect(response).to render_template(:set_password_and_email)
      end
    end
  end
end
