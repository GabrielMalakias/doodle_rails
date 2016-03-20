module Layer
  class Conversation::CreatorService
    def initialize(participants)
      @participants = participants
    end

    def call
      Layer::Conversation.create(participants: @participants)
    end
  end
end
