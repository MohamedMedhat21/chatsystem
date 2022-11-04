module Api
  module V1
    class ApplicationsController < ApplicationController

      def index
        # render json: Application.pluck(:name, :token)
        applications = Application.all
        render json: applications.select(:name,:token,:chat_count).to_json(except: :id)
      end

      def create
        application = Application.new(name:application_params[:name])

        if application.save
          render json:{
            name:application.name,
            token:application.token
          }, status: :created
        else
          render json:application.errors,status: :unprocessable_entity
        end
      end


      def show
        application = Application.where(token: params[:token]).first
        render json:{
          name:application.name,
          token:application.token,
          chat_count:application.chat_count
        },status: :ok
      end

      def update
        application = Application.where(token: params[:token]).first
        if application.update(name:application_params[:name])
          head :no_content
        else
          render json:application.errors,status: :unprocessable_entity
        end
      end

      private

      def application_params
        params.require(:application).permit(:name)
      end
    end
  end
end
