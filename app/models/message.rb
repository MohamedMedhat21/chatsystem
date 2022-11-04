class Message < ApplicationRecord
    belongs_to :chat
    validates :content, presence: true

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    
end
