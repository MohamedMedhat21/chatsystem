class Message < ApplicationRecord
    belongs_to :chat
    validates :content, presence: true

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

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
