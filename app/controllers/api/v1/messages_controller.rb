module Api
    module V1
      class MessagesController < ApplicationController
        before_action :get_app_chat

        def index
          messages = @chat.messages
          render json: messages.to_json(only: [:number,:content])
        end
        
        def create
          message = Message.new(chat_id:@chat.id,content:params[:content])
          message.number = message.generate_msg_number(@application.id)
          if message.valid?
            MessageCreationJob.perform_async(message.chat_id,message.number,message.content)
            render json: message.to_json(only: [:number]), status: :created
          else
            render json:message.errors,status: :unprocessable_entity
          end
        end

        def show
          message = @chat.messages.where(number: params[:number]).first
          if message.nil?
            render json: { error: "Couldn't find Message with 'number'= #{params[:number]}" }, status: :not_found
          else
            render json: message.to_json(only: [:number,:content]), status: :ok
          end
        end


        def update
          message = @chat.messages.where(number: params[:number]).first
          if message.update(content: params[:content])
              head :no_content
          else
              render json: message.errors, status: :unprocessable_entity
          end
        end
        
        def search
          messages = @chat.messages.search_msgs(params[:query],@chat.id).records
          render json: messages.to_json(only: [:number,:content])
        end

        private

        def get_app_chat
          @application = Application.where(token: params[:application_token]).first
          @chat = @application.chats.where(number: params[:chat_number]).first
        end
      end
    end
  end
  