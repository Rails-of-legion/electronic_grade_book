require 'rails_helper'

RSpec.describe 'RecordBooksIntermediateAttestations' do
  describe 'GET /index' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/record_books_intermediate_attestations/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
