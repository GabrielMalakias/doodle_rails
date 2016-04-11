module Doodle
  class User < ActiveRecord::Base
    has_many :user_channels
    has_many :channels, through: :user_channels
    has_many :protocols

    scope :inative, -> { User.where.not(id: UserChannel.user_by_status('online')) }

    def has_permission?(channel)
      Channel.has_user?(channel, self.login).count > 0
    end
  end
end
