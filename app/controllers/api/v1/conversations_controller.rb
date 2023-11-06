# app/controllers/api/v1/conversations_controller.rb
class Api::V1::ConversationsController < ApplicationController
    # include Devise::Controllers::Helpers
    # before_action :authenticate_user!
    # def create
    # #     user_id = params[:user_id] # Get the user ID from the request parameters
    # #     conversation = Conversation.create(user_id: user_id)
    # #   render json: conversation
    #     conversation = Conversation.create
    #     if conversation.persisted?
    #         render json: conversation
    #     else
    #         render json: { error: 'Failed to create conversation' }, status: :internal_server_error
    #     end
    # end

    # def index
    #     @conversations = Conversation.all
    #   end
    def index
        @user = current_user

        conversations = @user.conversations.uniq
        render json: {
          conversations: conversations
        }
      end
    
      def create
        @user = current_user

        @conversation = @user.conversations.new(conversation_params)
    
        if @conversation.save
          add_users_to_conversation
          render json: {
            conversation: @conversation,
            users: @conversation.users
          }
        else
          render json: { message: 'Unable to create conversation! Please try again.'}
        end
      end
    
      def show
        @user = current_user
        @conversation = @user.conversations.find(params[:id])
        render json: @conversation, status: :created
      end

      private

  def add_users_to_conversation
    users = params[:users]
    params[:users].each do |name|
      user = User.find_by(username: name)
      (@conversation.users << user) unless @conversation.users.include?(user) 
    end
  end
  
  def conversation_params
    params.require(:conversation).permit(:title, users: [])
  end

#   def authenticate_user
#     decoded_token = decode(request.headers['token'])
#     @user = User.find(decoded_token["user_id"])
#     render json: { message: 'Un-Authenticated Request', authenticated: false } unless @user
#   end
end
  