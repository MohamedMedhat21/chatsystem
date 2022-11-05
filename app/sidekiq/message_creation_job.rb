class MessageCreationJob
  include Sidekiq::Job
  sidekiq_options retry:0

  def perform(chat_id,msg_num,content)
    message = Message.new(chat_id:chat_id,number:msg_num,content:content)
    message.save
  end
end
