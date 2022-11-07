class Message < ApplicationRecord
    belongs_to :chat
    validates :content, presence: true

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


    def generate_msg_number(application_id)
        application = Application.where(id: application_id).first
        chat = application.chats.where(number: self.chat_id).first
        if chat.messages.last.nil?
            self.number = 1
        else
            self.number = chat.messages.last.number + 1
        end
    end


    mapping do
        indexes :content, type: 'text'
    end

    def self.search_msgs(query,chat_id)
        __elasticsearch__.search({
            query: {
                bool: {
                    must: {
                        wildcard:{
                            content: '*'+query+'*'
                        }
                    },
                    filter: {
                        term: {
                            chat_id: chat_id
                        }
                    }
                }
            }
        })
    end

end
