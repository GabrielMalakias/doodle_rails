module Layer
  class Conversation::FinderService
    def initialize(conversation_id)
      @conversation_id = conversation_id
    end

    def call
      Layer::Conversation.find(@conversation_id)
    end
  end
end
