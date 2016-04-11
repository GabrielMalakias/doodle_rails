require_dependency "doodle/application_controller"

module Doodle
  class ConversationsController < ApplicationController
    def create
      channel  = channel_finder_service.call.first

      if channel.present?
        conversation = conversation_creator_service([params.require(:login)]).call
        protocol = protocol_creator_service(channel, conversation).call
        render json: { protocol_id: protocol.id, prococol_status: protocol.status, channel: channel.name, conversation_id: conversation.id }, status: 201
      else
        render json: { error: 'Channel dont found, Please create channel with this name first' }
      end
    end

  def messages
    if params.permit(:conversation_id).present?
      @conversation = finder_service.call
      render json: @conversation.messages.to_json, status: 200
    else
      render json: { error: 'conversation_id can\'t be blank'}, status: 404
    end
  end

    def finder_service
      @finder_service ||= Layer::Conversation::FinderService.new("layer:///conversations/#{params.require(:conversation_id)}")
    end

    def channel_finder_service
      @channel_finder_service ||= Channel::FinderService.new({name: params.require(:channel)})
    end

    def protocol_creator_service(channel, conversation)
      @protocol_creator_service ||= Protocol::CreatorService.new(params.require(:login), channel, conversation)
    end

    def conversation_creator_service(participants)
      @conversation_creator_service ||= ::Layer::Conversation::CreatorService.new(participants)
    end
  end
end

