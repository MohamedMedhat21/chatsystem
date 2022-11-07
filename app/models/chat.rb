class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages
    

    def generate_number
        application = Application.where(id: self.application_id).first
        if application.chats.last.nil?
            self.number = 1
        else
            self.number = application.chats.last.number + 1
        end
    end
end
