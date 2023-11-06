# app/controllers/messages_controller.rb

class Api::V1::MessagesController < ApplicationController

    def create
        @user = current_user

        message = @user.messages.new(message_params)
        
        if message.save
          conversation = message.conversation
          ConversationChannel.broadcast_to(conversation, {
              conversation: conversation,
              users: conversation.users,
              messages: conversation.messages
          })
        end
        render json: message
      end
    
      private
    
      def message_params
          params.require(:message).permit(:body, :conversation_id)
      end
    

    # def create
    #     @chatroom = Chatroom.find(params[:chatroom_id])
    #     @message = @chatroom.messages.new(message_params)
    #     @message.user = current_user
    #     @message.save
    #   end
    
    #   private
    #   def message_params
    #     params.require(:message).permit(:body, :chatroom_id, :user_id)
    #   end

    # def create
    #     # @conversation = Conversation.find_or_create_by(id: params[:message][:conversation_id])
    #     # @message = Message.create(message_params)
    #     # # @conversation = Conversation.find(@message[:conversation_id])
    #     # ConversationChannel.broadcast_to(@conversation, @message)
    #     # render json: @message
    #     # Check if a conversation with the given ID exists; if not, create it
    #     @conversation = Conversation.find_or_create_by(id: params[:message][:conversation_id])

    #     # Build the message within the conversation
    #     @message = @conversation.messages.build(message_params)

    #     if @message.save
    #         ConversationChannel.broadcast_to(@conversation, @message)
    #         render json: @message
    #     else
    #         # Handle validation errors or other issues
    #         # Return appropriate responses or errors
            # render json: @message.errors, status: :unprocessable_entity
    #     end
    # end

    # def create
    #     conversation_id = params.dig(:message, :conversation_id)
    #     user_id = params.dig(:message, :user_id)
      
    #     # Make sure both conversation_id and user_id are provided
    #     if conversation_id.present? && user_id.present?
    #       @conversation = Conversation.find_or_create_by(id: conversation_id, user_id: user_id)
      
    #       if @conversation.persisted?
    #         @message = @conversation.messages.build(message_params)
      
    #         if @message.save
    #           ConversationChannel.broadcast_to(@conversation, @message)
    #           render json: @message
    #         else
    #           # Handle validation errors or other issues
    #           # Return appropriate responses or errors
    #         render json: { error: 'message not created' }, status: :not_found
    #         end
    #       else
    #         render json: { error: 'Conversation not found or created' }, status: :not_found
    #       end
    #     else
    #       render json: { error: 'Both conversation_id and user_id are required' }, status: :bad_request
    #     end
    #   end
      

    # private
    
    # def message_params
    #     # params.permit(:content, :conversation_id, :user_id, :read)
    #     params.require(:message).permit(:body, :conversation_id, :user_id)
    # end

    # def create
    #     chat = Chat.find(params[:chat_id])
    #     message = chat.messages.create(user: current_user, text: params[:message][:text])
    #     ChatChannel.broadcast_to(chat, message: message, user_id: current_user.id)
    #     render json: message
    #   end

    # def create_message
    #     message = Message.new_message(params)
    #     render json: message, status: :created
    #   end
    
    #   def message_history # get message history of a single matched user
    #     messages = Message.messages(params)
    #     render json: messages, status: :ok
    #   end

    #   def message_histories # get message histories of all the matched users
    #     user = User.find(params[:user_id])
    #     matched_users = user.get_match_users
    #     list_messages = Message.list_messages(user, matched_users)
    #     render json: list_messages, status: :ok
    #   end

    #   def message_histories
    #     all_users = User.all
    #     list_messages = Message.list_messages(current_user, all_users)
    #     render json: list_messages, status: :ok
    #   end
    # before_action :authenticate_user
#     before_action :find_receiver, only: [:create]
  
#     # Create a new message
#     def create
#       if current_user.client?
#         @message = current_user.sent_messages.build(message_params)
#         @message.receiver = @receiver
#         if @message.save
#           render json: @message, status: :created
#         else
#           render json: { error: 'Failed to send the message' }, status: :unprocessable_entity
#         end
#       else
#         render json: { error: 'Only clients can send messages' }, status: :forbidden
#       end
#     end
  
#     # List messages between the current user and a specific receiver
#     def index
#       @receiver = User.find(params[:receiver_id])
#       @messages = Message.where('(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)',
#                                  current_user.id, @receiver.id, @receiver.id, current_user.id)
#                          .order(:created_at)
#       render json: @messages
#     end
  
#     private
  
#     # Message params
#     def message_params
#       params.require(:message).permit(:content)
#     end
  
#     # Find the message receiver by ID
#     def find_receiver
#       @receiver = User.find(params[:receiver_id])
#     end
  
#     # Authentication logic (you can use a gem like Devise)
#     def authenticate_user
#     #   unless current_user
#     #     render json: { error: 'Please log in to send messages' }, status: :unauthorized
#     #   end
#     # end
  end
  