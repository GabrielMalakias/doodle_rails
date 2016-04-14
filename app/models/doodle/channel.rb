module Doodle
  class Channel < ActiveRecord::Base
    has_many :user_channels
    has_many :users, through: :user_channels

    has_many :protocols

    accepts_nested_attributes_for :user_channels, allow_destroy: true

    scope :has_user?, -> (channel_name, user_login) { joins(:users).where(name: channel_name, 'doodle_users.login' => user_login) }

    def self.find_protocols_by_channel(name)
      Channel.find_by_name(name).protocols
    end
  end
end
