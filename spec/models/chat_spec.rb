require 'rails_helper'

RSpec.describe Chat, type: :model do
  before(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
  it "generate chat number works" do
    chat = FactoryBot.create(:chat)
    chat2 = FactoryBot.create(:chat,application_id:1)
    chat3 = FactoryBot.create(:chat,application_id:1)
    chat4 = FactoryBot.create(:chat)
    chat5 = FactoryBot.create(:chat)
    chat6 = FactoryBot.create(:chat,application_id:2)
    expect(chat.number).to eq(1)
    expect(chat2.number).to eq(2)
    expect(chat3.number).to eq(3)
    expect(chat4.number).to eq(1)
    expect(chat5.number).to eq(1)
    expect(chat6.number).to eq(2)
  end
end
