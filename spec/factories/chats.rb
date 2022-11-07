FactoryBot.define do
  factory :chat do
    messages_count { 0 }
    application
    before(:create) do |chat|
      chat.generate_number
    end
  end
end
