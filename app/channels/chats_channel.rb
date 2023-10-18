class ChatsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stop_all_streams
    stream_from "chat_#{params[:user_id]}#{params[:recipient_id]}" 
    # if params[:sender_type] == "creator" && params[:recipient_type] == "client"
    #   stream_from "chat_creator_#{params[:sender_id]}_to_client_#{params[:recipient_id]}"
    # elsif params[:sender_type] == "client" && params[:recipient_type] == "creator"
    #   stream_from "chat_client_#{params[:sender_id]}_to_creator_#{params[:recipient_id]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
