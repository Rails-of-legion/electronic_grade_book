require 'rails_helper'

RSpec.describe "MarksReports", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/marks_reports/create"
      expect(response).to have_http_status(:success)
    end
  end

end
