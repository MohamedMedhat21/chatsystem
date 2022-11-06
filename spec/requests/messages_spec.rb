require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /messages" do
    it "works! (now write some real specs)" do
      get '/api/v1/applications/epm2i_NjUMadgVGAvwQvng/chats/1/messages'
      expect(response).to have_http_status(200)
    end
  end
end
