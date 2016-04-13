require_dependency "doodle/application_controller"

module Doodle
  class ChatController < ApplicationController
    before_filter :find_analyst

    def has_protocols?
      protocols = protocol_finder_service.waiting_on_user_channels(@user)

      render json: { has_protocols: protocols.count }, status: 200
    end

    def next
      if @user.blank?
        render json: { error: 'Dont found this analyst' }
      else
        protocol = protocol_finder_service.next_for_user(@user)

        if protocol.blank?
          render json: { error: 'Dont found protocols for this channel' }
        else
          join_service = chat_join_service(protocol, @user)
          if join_service.break_limit? && protocol.blank?
            render json: { error: 'Analyst already have limit of protocols in progress' }, status: 422
          else
            join_service.join(protocol.channel_id)
            render json: { conversation: protocol.conversation_id }, status: 200
          end
        end
      end
    end

    def finalize
      protocol = protocol_finder_service.find_by_conversation(params.require(:conversation_id))

      if protocol.blank?
        render json: { text: "Protocol isn't found"}, status: 422
      else

        protocol_finalizer_service(protocol).call
        chat_join_service(protocol, protocol.user).out(protocol.channel.name) if params.require(:analyst)

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

    private

    def find_analyst
      @user = User::Analyst.find_by_login(params.require(:login))
    end

  end
end
