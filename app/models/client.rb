class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    include Devise::JWT::RevocationStrategies::JTIMatcher
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  
     # Include Devise Token Auth for token generation
    #  include DeviseTokenAuth::Concerns::User
  
     # Attributes
    #  attr_accessor :role
    #  # Add the 'username' attribute
    #   attr_accessor :username
    
    # Callback to set provider to 'email' if it's blank
    # before_save -> { self.provider = 'email' if provider.blank? }
  
     # Validation
     validates :username, presence: true
     validates :email, presence: true, uniqueness: { case_sensitive: false }
  
       # Define followers and following associations for both clients and creators
       has_many :followers, foreign_key: 'follower_id'
       has_many :following, foreign_key: 'following_id'
    # attr_accessor :balance, :username
    attr_accessor :jti

    has_many :likes, foreign_key: :client_id # To track likes on posts
    has_many :bookmarks, foreign_key: :client_id # To track bookmarks on creator's posts
  # Define messages association
    has_many :messages, foreign_key: :sender_id, class_name: 'Message'

    # Associations
    has_many :transactions # To track deposits and purchases
    has_many :purchases, through: :transactions, source: :content # To track purchases
    # has_many :messages, foreign_key: :sender_id # To handle messages
    has_many :favorite_creators, foreign_key: :client_id # To track favorite creators
end
