require_dependency "doodle/application_controller"

module Doodle
  class UsersController < ApplicationController

    def join
      user = User::Analyst.find_by_params(users_params[:login])
      channel = params.require(:channel)

      if user
        if user.has_channels?
          user.enter_in_channel(channel)
        end
        render json: { channel: channel }, status: 200
      end

      render json: { error: 'User not found' }, status: 404

    end

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
