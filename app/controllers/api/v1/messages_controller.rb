module Api
    module V1
      class MessagesController < ApplicationController
        before_action :get_app_chat

        def index
          messages = @chat.messages
          render json: messages.select(:number,:content).to_json(except: :id)
        end
        
        def create
          if @chat.messages.last.nil?
            msg_num = 1
          else
            msg_num = @chat.messages.last.number + 1
          end
          message = Message.new(chat_id:@chat.id,number:msg_num,content:params[:content])
  
          if message.valid?
            MessageCreationJob.perform_async(message.chat_id,message.number,message.content)
            render json:{
              number:message.number
            }, status: :created
          else
            render json:message.errors,status: :unprocessable_entity
          end
        end

        def show
          message = @chat.messages.where(number: params[:number]).first
          if message.nil?
            render json: { error: "Couldn't find Message with 'number'= #{params[:number]}" }, status: 404
          else
            render json:{
                number:message.number,
                content:message.content
            },status: :ok
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
          render json: messages.to_json(except: [:id,:chat_id,:created_at,:updated_at])
        end

        private

        def get_app_chat
          @application = Application.where(token: params[:application_token]).first
          @chat = @application.chats.where(number: params[:chat_number]).first
        end
      end
    end
  end
  