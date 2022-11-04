module Api
    module V1
      class ChatsController < ApplicationController
        def index
          # render json: Application.pluck(:name, :token)
          application = Application.where(token: params[:application_token]).first
          chats = application.chats
          render json: chats.select(:number,:messages_count).to_json(except: :id)
        end
        
        def create
            application = Application.where(token: params[:application_token]).first
            chat = Chat.new(application_id:2,number:1)
    
            if chat.save
              render json:{
                number:chat.number
              }, status: :created
            else
              render json:chat.errors,status: :unprocessable_entity
            end
        end


        def show
          application = Application.where(token: params[:application_token]).first
          chat = application.chats.where(number: params[:number]).first
          render json:{
              number:chat.number,
              messages_count:chat.messages_count
          },status: :ok
        end


        def update
          application = Application.where(token: params[:application_token]).first
          chat = application.chats.where(number: params[:number]).first
          if chat.update(messages_count: params[:messages_count])
            head :no_content
          else
            render json: chat.errors, status: :unprocessable_entity
          end
        end
  
      end
    end
  end
  