require 'rails_helper'

RSpec.describe "ExtendsReports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/extends_reports/index"
      expect(response).to have_http_status(:success)
    end
  end

end
