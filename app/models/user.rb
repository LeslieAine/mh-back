class User < ApplicationRecord
  rolify
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
 
   # Define roles (client/creator)
  #  enum role: { client: 0, creator: 1 }

     # Define followers and following associations for both clients and creators
  # has_many :followers, class_name: 'User', foreign_key: 'follower_id'
  # has_many :following, class_name: 'User', foreign_key: 'following_id'
  # has_one_attached :avatar
  has_many :posts, foreign_key: 'user_id'
  has_many :contents

  has_many :likes, foreign_key: :user_id # To track likes on posts
  has_many :bookmarks, foreign_key: :user_id # To track bookmarks on creator's posts

  has_many :notifications
  has_many :chats
  has_many :rooms, through: :chats

  acts_as_follower
  acts_as_followable

   # Define messages association
  #  has_many :messages, foreign_key: :sender_id, class_name: 'Message'
  # has_many :messages
  # has_many :conversations
  # has_many :conversations_as_user1, class_name: 'Conversation', foreign_key: 'user1_id'
  # has_many :conversations_as_user2, class_name: 'Conversation', foreign_key: 'user2_id'

   after_create :assign_default_role

  #  def assign_default_role(role)
  #   add_role(role)
  # end
  def assign_default_role
    # Check the 'role' attribute of the user and assign a role based on its value
    case self.role
    when 'creator'
      add_role(:creator)
    when 'client'
      add_role(:client)
    else
      # Default role if 'role' is not 'creator' or 'client'
      add_role(:client)
    end
  end

  # role_param = self.role.downcase if self.role.present?
    
    # You can customize this logic to match your allowed roles
    # if role_param == "creator"
    #   add_role(:creator)
    # elsif role_param == "client"
    #   add_role(:client)
    # end


  #  before_save :assign_role

  #  def assign_role
  #   self.role = Role.find_by name: 'Client' if role.nil?
  # end
  #  def assign_default_role
  #   if self.role.present?
  #     add_role(self.role)
  #   else
  #     # Assign a default role if no role was specified during registration
  #     add_role(:client)
  # end
# end
end
