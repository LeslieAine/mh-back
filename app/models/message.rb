class Message < ApplicationRecord
   # Associations
  #  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  #  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
 
  #  # Validations (You can add additional validations as needed)
  #  validates :sender_id, presence: true
  #  validates :receiver_id, presence: true
  #  validates :content, presence: true
  #  validates :timestamp, presence: true
  validates :content, presence: true

  def self.new_message(params)
    browsed_user = User.find(params[:recipient_id])
    uuid = Match.where(user_id: params[:sender_id]).where(browsed_user_id: params[:recipient_id])[0][:pair_id]
    message = Message.create!(pair_id: uuid, sender_id: params[:sender_id], recipient_id: params[:recipient_id], content: params[:content])
    ActionCable.server.broadcast("chat_#{params[:recipient_id]}", "")
    ActionCable.server.broadcast("chat_#{params[:recipient_id]}#{params[:sender_id]}", message)
    return message
  end

  def self.messages(params)
    pair_id = Match.all.where(user_id: params[:sender_id]).where(browsed_user_id: params[:recipient_id])[0][:pair_id]
    Message.all.where(pair_id: pair_id)
    # Message.all.where(pair_id: pair_id).order(created_at: :desc).paginate(page: params[:page], per_page: 100)
  end
end
