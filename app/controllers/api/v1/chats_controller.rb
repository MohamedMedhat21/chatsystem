module Api
    module V1
      class ChatsController < ApplicationController
        before_action :get_application

        def index
          if @application.nil?
            head :not_found
          else
            chats = @application.chats
            render json: chats.to_json(only: [:number,:messages_count])
          end
        end
        
        def create
          if @application.nil?
            head :not_found
          else          
            chat = Chat.new(application_id:@application.id)
            chat.generate_number
            if chat.valid?
              ChatCreationJob.perform_async(chat.application_id,chat.number)
              render json: chat.to_json(only: [:number]),status: :created
            else
              render json:chat.errors,status: :unprocessable_entity
            end
          end
        end


        def show
          if @application.nil?
            head :not_found
          else
            chat = @application.chats.where(number: params[:number]).first
            render json: chat.to_json(only: [:number,:messages_count]),status: :ok
          end
        end

        # def update
        #   if @application.nil?
        #     head :not_found
        #   else
        #     chat = @application.chats.where(number: params[:number]).first
        #     if chat.update(messages_count: params[:messages_count])
        #       head :no_content
        #     else
        #       render json: chat.errors, status: :unprocessable_entity
        #     end
        #   end
        # end

        private

        def get_application
          @application = Application.where(token: params[:application_token]).first
        end
  
      end
    end
  end
  