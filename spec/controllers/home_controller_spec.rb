require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end

    it 'renders the home template' do
      get :home
      expect(response).to render_template(:home)
    end

    it 'does not require user authentication' do
      expect(controller).to receive(:authenticate_user!).never
      get :home
    end
  end

  describe 'GET #about' do
    it 'returns http success' do
      get :about
      expect(response).to have_http_status(:success)
    end

    it 'renders the about template' do
      get :about
      expect(response).to render_template(:about)
    end

    it 'does not require user authentication' do
      expect(controller).to receive(:authenticate_user!).never
      get :about
    end
  end
end
