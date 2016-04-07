module Doodle
  class UserChannel < ActiveRecord::Base
    include AASM

    belongs_to :user
    belongs_to :channel

    aasm column: :status do
      state :offline, initial: true
      state :online

      after_all_transitions :log_status_change

      event :turn_online do
        transitions from: :offline, to: :online
      end

      event :turn_offline do
        transitions from: :online, to: :offline
      end
    end

    def log_status_change
      Rails.logger.info "[POC] [CHANNEL] - Analyst #{self.user.login} change your status from #{aasm.from_state} to #{aasm.to_state}"
    end
  end
end
