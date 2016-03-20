module Doodle
  class ApplicationController < ActionController::Base
    def authenticate
      render json: { session_token: create_and_authenticate }
    end

    def authenticate_user

    end

    def auth_params
      params.require(:auth).permit(:login, :pass)
    end
  end
end
