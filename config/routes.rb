Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :applications, only: [:index,:create,:show,:update], param: :token do
        resources :chats ,only: [:index,:create,:show], param: :number do
          resources :messages,only: [:index,:create,:show,:update], param: :number
        end
      end
    end
  end

end
