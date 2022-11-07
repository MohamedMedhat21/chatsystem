class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages
    

    def generate_number
        application = Application.where(id: self.application_id).first
        lst_chat_num = 0
        if application.chats.last.nil? == false
            lst_chat_num = application.chats.last.number
        end
        self.number = lst_chat_num + 1
    end
end
