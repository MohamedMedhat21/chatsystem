require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "GET /applications" do
    it "works! (now write some real specs)" do
      get '/api/v1/applications'
      expect(response).to have_http_status(200)
    end
  end
end
