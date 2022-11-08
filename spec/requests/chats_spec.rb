require 'rails_helper'
require 'sidekiq/testing' 
Sidekiq::Testing.inline!

RSpec.describe "Chats", type: :request do
  describe "GET /api/v1/applications/:application_token/chats" do
    it "returns all chats" do
      chat = FactoryBot.create(:chat)
      chat2 = FactoryBot.create(:chat,application_id:1)
      get "/api/v1/applications/#{chat.application.token}/chats"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /api/v1/applications/:application_token/chats" do
    it "create a new chat" do
      application = FactoryBot.create(:application)
      expect{
        post "/api/v1/applications/#{application.token}/chats"
      }.to change{Chat.count}.from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['number']).to eq(1)
    end
  end

  describe "GET /api/v1/applications/:application_token/chats/:number" do
    it "show a existing chat" do
      chat = FactoryBot.create(:chat)
      get "/api/v1/applications/#{chat.application.token}/chats/#{chat.number}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['number']).to eq(chat.number)
      expect(JSON.parse(response.body)['messages_count']).to eq(chat.messages_count)
    end
  end
end
