require_dependency "doodle/application_controller"

module Doodle
  class UsersController < ApplicationController

    def create
      user = User.new(users_params)
      if user.save
        render json: user.reload.to_json
      else
        render json: {error: 'When save keyword'}.to_json
      end
    end

    def users_params
      params.require(:user).permit(:login, :pass, :type)
    end
  end
end
