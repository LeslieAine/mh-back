class Client < User
    attr_accessor :balance, :username

    # Associations
    has_many :transactions # To track deposits and purchases
    has_many :purchases, through: :transactions, source: :content # To track purchases
    has_many :messages, foreign_key: :sender_id # To handle messages
    has_many :favorite_creators, foreign_key: :client_id # To track favorite creators
end
