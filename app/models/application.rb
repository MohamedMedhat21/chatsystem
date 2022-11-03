class Application < ApplicationRecord
    has_many :chats
    before_create :generate_token
    validates :name, presence: true



    private

    def generate_token
        self.token = loop do
          random_token = SecureRandom.urlsafe_base64(nil, false)
          break random_token unless Application.exists?(token: random_token)
        end
    end
end
