require_dependency "doodle/application_controller"

module Doodle
  class ChannelsController < ApplicationController
    def index
      render json: Channel.all
    end
  end
end

