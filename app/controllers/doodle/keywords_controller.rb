require_dependency "doodle/application_controller"
require 'pry'

module Doodle
  class KeywordsController < ApplicationController

    def create
      keyword = Keyword.new(keyword_params)
      if keyword.save
        render json: keyword.reload.to_json
      else
        render json: {error: 'When save keyword'}.to_json
      end
    end

    def index
      if params[:keyword].present?
        render json: finder_service.to_json
      else
        render json: Keyword.all.to_json
      end
    end

    def keyword_params
      params.require(:keyword).permit(:name, :value, :type)
    end

    def finder_service
      @finder_service || Doodle::Keyword::FinderService.new(keyword_params)
    end
  end
end
