require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
  it "must have a correct data" do
    application = FactoryBot.create(:application)
    expect(application.name).not_to eq("")
    expect(application.token).not_to eq("")
    expect(application.chat_count).to eq(0)
  end
end
