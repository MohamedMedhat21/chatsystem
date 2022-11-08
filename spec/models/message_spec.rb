require 'rails_helper'

RSpec.describe Message, type: :model do
  it "generate message number works" do
    msg1 = FactoryBot.create(:message)
    msg2 = FactoryBot.create(:message,chat_id:1)
    msg3 = FactoryBot.create(:message,chat_id:1)
    msg4 = FactoryBot.create(:message)
    msg5 = FactoryBot.create(:message)
    expect(msg1.number).to eq(1)
    expect(msg2.number).to eq(2)
    expect(msg3.number).to eq(3)
    expect(msg4.number).to eq(1)
    expect(msg5.number).to eq(1)
  end
  it "validation works" do
    msg6 = FactoryBot.build(:message,content:"hello")
    msg7 = FactoryBot.build(:message,content:"")
    expect(msg6).to be_valid
    expect(msg7).to_not be_valid
  end
end
