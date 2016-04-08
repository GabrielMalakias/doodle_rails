require_dependency "doodle/application_controller"

module Doodle
  class ChatController < ApplicationController

    def has_protocols?
      protocols = Protocol.waiting_in_channel(params.require(:channel))
      render json: { has_protocols: protocols.size }, status: 200
    end

    def next
      user = User::Analyst.find_by_login(params.require(:login))
      if user.blank?
        render json: { error: 'Dont found this analyst' }
      else
        protocol = protocol_finder_service.next(params.require(:channel))

        if protocol.blank? || user.blank?
          render json: { error: 'Dont find protocols for this channel' }
        else
          join_service = chat_join_service(protocol, user)
          if join_service.break_limit? && protocol.blank?
            render json: { error: 'Analyst already have limit of protocols in progress' }, status: 422
          else
            join_service.join(params.require(:channel))
            render json: { conversation: protocol.conversation_id }, status: 200
          end
        end
      end
    end

    def finalize
      user = User::Analyst.find_by_login(params.require(:login))
      protocol = protocol_finder_service.find_by_conversation(params.require(:id))

      if user.blank? || protocol.blank?
        render json: { text: "Protocol or user dont found"}, status: 422
      else

        protocol_finalizer_service(protocol).call
        chat_join_service(protocol, user).out(protocol.channel.name)

        render json: { id: protocol.id, text: "Protocol finalized with success" }
      end
    end

    def protocol_finalizer_service(protocol)
      @protcol_finalizer_service ||= Protocol::FinalizerService.new(protocol)
    end

    def chat_join_service(protocol, user)
      @chat_join_service ||= Chat::JoinService.new(user, protocol)
    end

    def protocol_finder_service
      @finder_service ||= Protocol::FinderService.new
    end
  end
end

