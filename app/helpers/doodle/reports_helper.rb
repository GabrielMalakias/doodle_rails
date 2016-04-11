module Doodle
  module ReportsHelper
    module_function

    def online_users_and_protocols_in_progress
      result = {}
      protocols_in_progress = Doodle::Protocol.number_by_user(Doodle::UserChannel.user_by_status('online'))
      protocols_in_progress.each do |k, v|
        result =result.merge({login: User.find(k).login, number: v})
      end
      result
    end
  end
end
