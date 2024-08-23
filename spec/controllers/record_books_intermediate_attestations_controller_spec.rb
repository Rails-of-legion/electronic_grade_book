require 'rails_helper'

RSpec.describe RecordBooksIntermediateAttestationsController, type: :controller do
  let(:valid_attributes) do
    {
      record_book_id: create(:record_book).id,
      intermediate_attestation_id: create(:intermediate_attestation).id
    }
  end

  let(:invalid_attributes) do
    {
      record_book_id: nil,
      intermediate_attestation_id: nil
    }
  end
  let(:user) { create(:user, :as_admin) }
  let(:record_books_intermediate_attestation) { create(:record_books_intermediate_attestation) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all record_books_intermediate_attestations as @record_books_intermediate_attestations' do
      get :index
      expect(assigns(:record_books_intermediate_attestations)).to include(record_books_intermediate_attestation)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested record_books_intermediate_attestation as @record_books_intermediate_attestation' do
      get :show, params: { id: record_books_intermediate_attestation.to_param }
      expect(assigns(:record_books_intermediate_attestation)).to eq(record_books_intermediate_attestation)
    end
  end

  describe 'GET #new' do
    it 'assigns a new record_books_intermediate_attestation as @record_books_intermediate_attestation' do
      get :new
      expect(assigns(:record_books_intermediate_attestation)).to be_a_new(RecordBooksIntermediateAttestation)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested record_books_intermediate_attestation as @record_books_intermediate_attestation' do
      get :edit, params: { id: record_books_intermediate_attestation.to_param }
      expect(assigns(:record_books_intermediate_attestation)).to eq(record_books_intermediate_attestation)
    end
  end
end
