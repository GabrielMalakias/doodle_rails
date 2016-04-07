module Doodle
  class User::Analyst < User

    def enter_in_channel(name)
      user_channel = user_channel_by_name(name)
      user_channel.turn_online! if user_channel.may_turn_online?
    end

    def out_of_channel(name)
      user_channel = user_channel_by_name(name)
      user_channel.turn_offline! if user_channel.may_turn_offline?
    end

    def user_channel_by_name(name)
      self.user_channels.joins(:channel).where('doodle_channels.name' => name).first
    end

    def break_limit_concurrent_protocols?
      self.protocols.where.not(status: 'finalized').count > self.concurrent_protocols
    end
  end
end
