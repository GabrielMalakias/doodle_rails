module Doodle
  class User < ActiveRecord::Base
    has_many :user_channels
    has_many :channels, through: :user_channels



  end
end
