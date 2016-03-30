module Doodle
  class User::Analyst < User

    def out_of_channel(name)
      user_channel = user_channel_by_name(name)
      user_channel.turn_offline! if user_channel.may_turn_offline?
    end

    def user_channel_by_name(name)
      self.user_channels.joins(:channel).where('doodle_channels.name' => name).first
    end
  end
end
