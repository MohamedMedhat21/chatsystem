FactoryBot.define do
  factory :chat do
    number { 1 }
    messages_count { 0 }
    application
  end
end
