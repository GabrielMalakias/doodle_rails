module Doodle
  class Protocol::CreatorService
    def initialize(customer_login, channel, conversation)
      @customer_login = customer_login
      @channel = channel
      @conversation = conversation
    end

    def call
      Protocol.create(customer_login: @customer_login,
                      channel: @channel,
                      conversation_id: @conversation.id,
                      phone: '(XX) XXXX-XXXX')
    end
  end
end
