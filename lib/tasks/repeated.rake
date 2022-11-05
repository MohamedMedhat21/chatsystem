namespace :repeated do
  desc "TODO"
  task update_counts: :environment do
    Application.find_each do |app|
      app.update_column(:chat_count,app.chats.size)
    end
    Chat.find_each do |chat|
      chat.update_column(:messages_count,chat.messages.size)
    end
  end
end