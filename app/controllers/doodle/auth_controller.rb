require_dependency "doodle/application_controller"

module Doodle
  class AuthController < ApplicationController
    def authenticate
      @user = User.where(password: auth_params[:password], login: auth_params[:login], type: auth_params[:type]).first

      if @user.present?
        render json: { id: @user.id, login: @user.login, session_token: token_creator_service.token }
      else
        render json: { error: "When authenticate user" }
      end
    end

    def auth_params
      @params ||= params.require(:auth).permit(:login, :password, :type)
    end

    def token_creator_service
      @creator_service ||= Layer::TokenCreatorService.new(@user.login)
    end
  end
end
