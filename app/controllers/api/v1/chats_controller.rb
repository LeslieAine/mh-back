# app/controllers/api/chats_controller.rb

class Api::V1::ChatsController < ApplicationController
    before_action :authenticate_user
  
    def index
      chats = current_user.chats
      render json: chats
    end
  
    def create
      chat = current_user.chats.create(chat_params)
      render json: chat
    end
  
    private
  
    def chat_params
      params.require(:chat).permit(:name)
    end
  end
  