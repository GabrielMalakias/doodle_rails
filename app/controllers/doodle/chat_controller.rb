require_dependency "doodle/application_controller"

module Doodle
  class ChatController < ApplicationController

    def has_protocols?
      binding.pry
      protocols = Protocol.waiting_in_channel(params.require(:channel))
      render json: { has_protocols: protocols.any? }, status: 200
    end
  end
end

