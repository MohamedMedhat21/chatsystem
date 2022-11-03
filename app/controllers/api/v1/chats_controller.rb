module Api
    module V1
      class ChatsController < ApplicationController
        def index
          # render json: Application.pluck(:name, :token)
          chat = Chat.select(:number, :application_id)
          render json: chat
        end
        
        def create
            application = Application.where(token: params[:application_token]).first
            chat = Chat.new(application_id:application.id,number:1)
    
            if chat.save
              render json:{
                number:chat.number,
                application_id:chat.application_id
              }, status: :created
            else
              render json:chat.errors,status: :unprocessable_entity
            end
        end


        def show
            chat = Chat.where(number: params[:number]).first
            render json:{
                number:chat.number,
                messages_count:chat.messages_count
            },status: :ok
        end
  
      end
    end
  end
  