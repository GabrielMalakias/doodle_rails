module Doodle
  class Channel::FinderService
    def initialize(params)
      @params = params
    end

    def call
      scope = nil
      @params.each do |k, v|
        scope = Doodle::Channel.where({k => v})
      end
      scope.all
    end
  end
end
