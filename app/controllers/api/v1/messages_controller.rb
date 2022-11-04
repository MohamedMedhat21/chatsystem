module Api
    module V1
      class MessagesController < ApplicationController
  
        def index
          # render json: Application.pluck(:name, :token)
          application = Application.where(token: params[:application_token]).first
          chat = application.chats.where(number: params[:chat_number]).first
          messages = chat.messages
          render json: messages.select(:number,:content).to_json(except: :id)
        end
        
        def create
            application = Application.where(token: params[:application_token]).first
            chat = application.chats.where(number: params[:chat_number]).first
            message = Message.new(chat_id:chat.id,number:1,content:params[:content])
    
            if message.save
              render json:{
                number:message.number
              }, status: :created
            else
              render json:message.errors,status: :unprocessable_entity
            end
        end

        def show
            application = Application.where(token: params[:application_token]).first
            chat = application.chats.where(number: params[:chat_number]).first
            message = chat.messages.where(number: params[:number]).first
            render json:{
                number:message.number,
                content:message.content
            },status: :ok
        end


        def update
            application = Application.where(token: params[:application_token]).first
            chat = application.chats.where(number: params[:chat_number]).first
            message = chat.messages.where(number: params[:number]).first
            if message.update(content: params[:content])
                head :no_content
              else
                render json: message.errors, status: :unprocessable_entity
              end
        end

      end
    end
  end
  