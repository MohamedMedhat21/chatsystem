FactoryBot.define do
  factory :message do
    content { "MyString" }
    chat
    before(:create) do |msg|
      msg.generate_msg_number(msg.chat.application.id)
    end
  end
end
