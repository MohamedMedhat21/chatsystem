require 'rails_helper'
require 'sidekiq/testing' 
Sidekiq::Testing.inline!

RSpec.describe "Messages", type: :request do
  describe "GET /api/v1/applications/:application_token/chats/:chat_number/messages" do
    it "returns all messages" do
      msg = FactoryBot.create(:message)
      msg2 = FactoryBot.create(:message,chat_id:1)
      get "/api/v1/applications/#{msg.chat.application.token}/chats/#{msg.chat.number}/messages"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /api/v1/applications/:application_token/chats/:chat_number/messages" do
    it "create a new message" do
      chat = FactoryBot.create(:chat)
      msg_content = "hello from the other side"
      expect{
        post "/api/v1/applications/#{chat.application.token}/chats/#{chat.number}/messages?content=#{msg_content}"
      }.to change{Message.count}.from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['number']).to eq(1)
    end
  end

  describe "GET /api/v1/applications/:application_token/chats/:chat_number/messages/:number" do
    it "show a existing message" do
      msg = FactoryBot.create(:message)
      get "/api/v1/applications/#{msg.chat.application.token}/chats/#{msg.chat.number}/messages/#{msg.number}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['number']).to eq(msg.number)
      expect(JSON.parse(response.body)['content']).to eq(msg.content)
    end
  end

  describe "PUT /api/v1/applications/:application_token/chats/:chat_number/messages/:number" do
    it "update a existing application" do
      msg = FactoryBot.create(:message)
      msg_content = "this is the new content"
      expect{
        put "/api/v1/applications/#{msg.chat.application.token}/chats/#{msg.chat.number}/messages/#{msg.number}?content=#{msg_content}"
      }.to change{Message.first.content}.from(msg.content).to(msg_content)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "GET /api/v1/applications/:application_token/chats/:chat_number/search" do
    it "returns matched messages' contents" do
      msg = FactoryBot.create(:message)
      # msg2 = FactoryBot.create(:message,chat_id:1)
      get "/api/v1/applications/#{msg.chat.application.token}/chats/#{msg.chat.number}/search?query=MyString"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
