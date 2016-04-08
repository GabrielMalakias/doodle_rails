module Doodle
  class User < ActiveRecord::Base
    has_many :user_channels
    has_many :channels, through: :user_channels
    has_many :protocols

    def has_permission?(channel)
      Channel.has_user?(channel, self.login).count > 0
    end
  end
end
