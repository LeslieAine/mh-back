# app/controllers/messages_controller.rb

class Api::V1::MessagesController < ApplicationController
    before_action :authenticate_user
    before_action :find_receiver, only: [:create]
  
    # Create a new message
    def create
      if current_user.client?
        @message = current_user.sent_messages.build(message_params)
        @message.receiver = @receiver
        if @message.save
          render json: @message, status: :created
        else
          render json: { error: 'Failed to send the message' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Only clients can send messages' }, status: :forbidden
      end
    end
  
    # List messages between the current user and a specific receiver
    def index
      @receiver = User.find(params[:receiver_id])
      @messages = Message.where('(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)',
                                 current_user.id, @receiver.id, @receiver.id, current_user.id)
                         .order(:created_at)
      render json: @messages
    end
  
    private
  
    # Message params
    def message_params
      params.require(:message).permit(:content)
    end
  
    # Find the message receiver by ID
    def find_receiver
      @receiver = User.find(params[:receiver_id])
    end
  
    # Authentication logic (you can use a gem like Devise)
    def authenticate_user
      unless current_user
        render json: { error: 'Please log in to send messages' }, status: :unauthorized
      end
    end
  end
  