class Message < ApplicationRecord
   # Associations
   belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
   belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
 
   # Validations (You can add additional validations as needed)
   validates :sender_id, presence: true
   validates :receiver_id, presence: true
   validates :content, presence: true
   validates :timestamp, presence: true
end
