module Api
  module V1
    class ApplicationsController < ApplicationController
      def index
        render json: Application.all
      end
    end
  end
end
