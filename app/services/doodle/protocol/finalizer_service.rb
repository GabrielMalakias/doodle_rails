module Doodle
  class Protocol::FinalizerService
    def initialize(protocol)
      @protocol = protocol
    end

    def call
      @protocol.finalize!
    end
  end
end
