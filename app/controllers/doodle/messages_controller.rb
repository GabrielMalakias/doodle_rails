require_dependency "doodle/application_controller"

module Doodle
  class MessagesController < ApplicationController
    def create
      conversation = Layer::Conversation.find(conversation_params[:id])

      if !message_params[:parts][0]['body'].blank?
        message = conversation.messages.create(message_params)
        render json: message, status: 201
      else
        render text: 'body cant be blank', status: 422
      end

    end

    def conversation_params
      params.require(:conversation)
    end

    def message_params
      {
        sender: conversation_params[:sender],
        parts: conversation_params[:parts].respond_to?(:values) ? conversation_params[:parts].values : conversation_params[:parts]
      }
    end
  end
end
