module Doodle
  class Protocol::FinderService
    def next(channel)
      protocol = Protocol.in_channel_with_status(user_channels_ids(user), Protocol::STATUSES[:waiting]).first
      return nil if protocol.blank?
      protocol.progress!
      protocol

    end

    def next_for_user(user)
      protocol = Protocol.in_channels_with_status(user_channels_ids(user), Protocol::STATUSES[:waiting]).first
      return nil if protocol.blank?
      protocol.progress!
      protocol
    end

    def waiting_on_user_channels(user)
      Protocol.in_channels_with_status(user_channels_ids(user), Protocol::STATUSES[:waiting])
    end

    def find_by_conversation(id)
      Protocol.find_by_conversation_id(id)
    end

    private
    def user_channels_ids(user)
      user.channels.pluck(:id)
    end

  end
end
