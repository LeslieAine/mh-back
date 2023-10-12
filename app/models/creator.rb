class Creator < User
    attr_accessor :balance, username

    # Associations
    has_many :contents # To track created content
    has_many :favorite_counts, class_name: 'User', foreign_key: 'favorite_creator_id' # To count favorited by users
    # has_many :posts # To track posts created by the creator
    has_many :orders # To handle orders
end
