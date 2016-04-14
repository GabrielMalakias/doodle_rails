module Doodle
  class History
    def initialize(conversation)
      @conversation = conversation
    end

    def self.find(conversation_id)
      self.new(Layer::Conversation.find("layer:///conversations/#{conversation_id}"))
    end

    def messages
      @conversation.messages.entries.map do |e|
        Message.new(e)
      end
    end
  end

  class Message
    def initialize(entries)
      @entries = entries
    end

    def parts
      @entries.parts.map { |p| {body: p.try(:[], 'body'), mime_type: p.try(:[], 'mime_type')} }
    end

    def sender
      @entries.sender.try(:[], 'user_id') || @entries.sender.try(:[], 'name')
    end

    def sent_at
      @entries.sent_at
    end
  end
end
