FactoryBot.define do
    factory :application do
        token { "token" }
        name { "app" }
        chat_count { 0 }
    end
end
