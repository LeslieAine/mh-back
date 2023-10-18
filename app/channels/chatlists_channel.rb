class ChatlistsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stop_all_streams
    stream_from "chat_#{params[:user_id]}" 
    # entity_id = params[:entity_id]
    # entity_type = params[:entity_type]
    
    # if entity_type == 'client'
    #   stream_from "chat_client_#{entity_id}"
    # elsif entity_type == 'creator'
    #   stream_from "chat_creator_#{entity_id}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
