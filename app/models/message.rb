class Message < ApplicationRecord
    belongs_to :chat
    validates :content, presence: true

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


    def generate_msg_number(application_id)
        application = Application.where(id: application_id).first
        chat = application.chats.where(id: self.chat_id).first
        lst_msg_num = 0
        if chat.messages.last.nil? == false
            lst_msg_num = chat.messages.last.number
        end
        self.number = lst_msg_num + 1
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
