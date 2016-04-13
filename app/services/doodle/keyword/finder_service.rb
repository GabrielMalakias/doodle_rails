module Doodle
  class Keyword::FinderService
    def initialize(params)
      @params = params
    end

    def call
      scope = nil
      @params.each do |k, v|
        scope = klass.where(k.to_s => v)
      end
      scope.all
    end

    def klass
      Doodle::Keyword
    end
  end
end
