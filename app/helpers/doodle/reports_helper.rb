module Doodle
  module ReportsHelper
    module_function

    def online_users_and_protocols_in_progress
      result = []
      protocols_in_progress = Doodle::Protocol.number_by_user(Doodle::UserChannel.user_by_status(UserChannel::STATUSES[:online]))
      protocols_in_progress.each do |k, v|
        result << {login: User.find(k).login, number: v}
      end
      result
    end

    def waiting_users
      result = []
      Doodle::User::Analyst.inative.pluck(:login).each do |v|
        result << {login: v}
      end
      result
    end

    def protocol_with_status(status)
      result = []
      Doodle::Channel.all.pluck(:name).each do |n|
        result << {name: n, number: Protocol.in_channel_with_status(n, status).count}
      end
      result
    end

    def service_metrics
      {
        waiting_time: "#{Doodle::Protocol.average_waiting_time.round / 60.to_f} min",
        service_time: "#{Doodle::Protocol.average_service_time.round / 60.to_f} min"
      }
    end
  end
end
