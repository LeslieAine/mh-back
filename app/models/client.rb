class Client < User
    attr_accessor :balance, :username

    # Associations
    has_many :transactions # To track deposits and purchases
    has_many :likes, foreign_key: :user_id # To track likes on posts
    has_many :bookmarks, foreign_key: :user_id # To track bookmarks on creator's posts
    has_many :purchases, through: :transactions, source: :content # To track purchases
    has_many :messages, foreign_key: :sender_id # To handle messages
    has_many :favorite_creators, foreign_key: :client_id # To track favorite creators
end
