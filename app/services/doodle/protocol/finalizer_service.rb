module Doodle
  class Protocol::FinalizerService
    def initialize(protocol)
      @protocol = protocol
    end

    def call
      @protocol.progress! if @protocol.waiting?
      @protocol.finalize!
    end
  end
end
