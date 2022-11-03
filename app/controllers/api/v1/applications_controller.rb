module Api
  module V1
    class ApplicationsController < ApplicationController
      def index
        # render json: Application.pluck(:name, :token)
        applications = Application.select(:name, :token)
        render json: applications
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

      private

      def application_params
        params.require(:application).permit(:name)
      end
    end
  end
end
