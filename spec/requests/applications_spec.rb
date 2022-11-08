require 'rails_helper'

RSpec.describe "Applications", type: :request do
  before(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
  describe "GET /api/v1/applications" do
    it "returns all applications" do
      application = FactoryBot.create(:application)
      application2 = FactoryBot.create(:application)
      # get '/api/v1/applications'
      get api_v1_applications_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /api/v1/applications" do
    it "create a new application" do
      expect{
        post api_v1_applications_path , params:{application:{name:'app1'}}
      }.to change{Application.count}.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /api/v1/applications/:token" do
    it "show a existing application" do
      application = FactoryBot.create(:application)
      get "/api/v1/applications/#{application.token}"
      # get api_v1_applications_path , params:{application:{token:application.token}}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(application.name)
      expect(JSON.parse(response.body)['token']).to eq(application.token)
      expect(JSON.parse(response.body)['chat_count']).to eq(application.chat_count)
    end
  end

  describe "PUT /api/v1/applications/:token" do
    it "update a existing application" do
      application = FactoryBot.create(:application)
      # get api_v1_applications_path , params:{application:{token:application.token}}
      expect{
        put "/api/v1/applications/#{application.token}" , params:{application:{name:"application"}}
      }.to change{Application.first.name}.from(application.name).to("application")
      expect(response).to have_http_status(:no_content)
    end
  end
end
