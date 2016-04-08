module Doodle
  class Protocol::FinderService
    def next(channel)
      Protocol.next(channel)
    end

    def find_by_conversation(id)
      Protocol.find_by_conversation_id(id)
    end
  end
end


