module Doodle
  class Protocol < ActiveRecord::Base
    include AASM
    belongs_to :channel
    belongs_to :user

    STATUSES  = {
      waiting:     'waiting',
      in_progress: 'in_progress',
      finalized:   'finalized'
    }

    scope :by_user, ->(user_ids){ where(user_id: user_ids) }
    scope :by_status, ->(status){ where(status: status) }
    scope :number_by_user, ->(user_ids) { by_status(STATUSES[:in_progress]).by_user(user_ids).group(:user_id).count }
    scope :in_channel_with_status, -> (channel, status){ by_status(status).joins(:channel).where("#{Doodle::Channel.table_name}.name" => channel) }

    aasm column: :status do
      state :waiting, initial: true
      state :in_progress
      state :finalized

      after_all_transitions :log_status_change

      event :progress do
        before do
          self.update(in_progress_at: Time.now)
        end

        transitions from: :waiting, to: :in_progress
      end

      event :finalize do
        before do
          self.update(finalized_at: Time.now)
        end

        transitions from: :in_progress, to: :finalized
      end
    end

    def duration
      return nil if self.finalized_at.blank?
      "#{(self.finalized_at - self.created_at).round / 60} min"
    end

    def log_status_change
      Rails.logger.info "[DOODLE] [PROTOCOL] - Protocol #{self.id} of customer #{self.customer_login} changed from #{aasm.from_state} to #{aasm.to_state}"
    end

    def add_analyst_into(user)
      self.user = user
      self.save
    end

    def add_participant_into_conversation(login)
      conversation = Layer::Conversation.find(self.conversation_id)
      conversation.participants << login
      conversation.save
    end

    def remove_participant_from_conversation(login)
      conversation = Layer::Conversation.find(self.conversation_id)
      conversation.participants = conversation.participants - [login]
      conversation.save
    end

    def self.next(channel)
      protocol = self.in_channel_with_status(channel, Protocol::STATUSES[:waiting]).first
      return nil if protocol.blank?
      protocol.progress!
      protocol
    end

  end
end
