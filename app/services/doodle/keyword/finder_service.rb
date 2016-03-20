module Doodle
  class Keyword::FinderService
    def initialize(params)
      @params = params
    end

    def call
      scope = nil
      @params.each do |k, v|
        scope = Doodle::Keyword.where(k, v)
      end
      scope.all
    end
  end
end
