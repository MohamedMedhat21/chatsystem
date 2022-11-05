class ChatCreationJob
  include Sidekiq::Job
  sidekiq_options retry:0

  def perform(application_id,number)
    chat = Chat.new(application_id:application_id,number:number)
    chat.save
  end
end
