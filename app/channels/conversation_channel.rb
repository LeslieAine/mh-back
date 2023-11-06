# conversation_channel.rb

# mount ActionCable.server => "/cable"

class ConversationChannel < ApplicationCable::Channel
  def subscribed
	  @conversation = Conversation.find(params[:id])
    stream_for @conversation
    # stream_from "some_channel"
  end

  def received(data)
    ConversationChannel.broadcast_to(@conversation, {conversation: @conversation, users: @conversation.users, messages: @conversation.messages})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
