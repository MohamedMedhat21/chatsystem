module Api
  module V1
    class ApplicationsController < ApplicationController
      before_action :get_application, only: [:show,:update]

      def index
        applications = Application.all
        render json: applications.to_json(only: [:name,:token,:chat_count])
      end

      def create
        application = Application.new(name:application_params[:name])
        if application.save
          render json: application.to_json(only: [:name,:token]), status: :created
        else
          render json:application.errors,status: :unprocessable_entity
        end
      end


      def show
        if @application.nil?
          head :not_found
        else
          render json: @application.to_json(only: [:name,:token,:chat_count]),status: :ok
        end
      end

      def update
        if @application.nil?
          head :not_found
        else
          if @application.update(name:application_params[:name])
            head :no_content
          else
            render json:@application.errors,status: :unprocessable_entity
          end
        end
      end

      private

      def application_params
        params.require(:application).permit(:name)
      end

      def get_application
        @application = Application.where(token: params[:token]).first
      end
    end
  end
end
