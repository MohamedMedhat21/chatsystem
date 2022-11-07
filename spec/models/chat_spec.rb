require 'rails_helper'

RSpec.describe Chat, type: :model do
  it "works" do
    application = FactoryBot.create(:application)
    chat = FactoryBot.create(:chat)
    chat2 = FactoryBot.create(:chat)
    expect(chat.number).to eq(1)
    expect(chat2.number).to eq(2)
  end
end
