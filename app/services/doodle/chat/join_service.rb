module Doodle
  class Chat::JoinService
    def initialize(user, protocol)
      @protocol = protocol
      @user = user
    end

    def join(channel)
      @protocol.add_analyst_into(@user)
      @protocol.add_participant_into_conversation(@user.login)
      @user.enter_in_channel(channel)
    end

    def break_limit?
      @user.break_limit_concurrent_protocols?
    end

    def out(channel)
      @protocol.remove_participant_from_conversation(@user.login)
      @user.out_of_channel(channel)
    end
  end
end
