class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   # Include Devise Token Auth for token generation
   include DeviseTokenAuth::Concerns::User

   # Attributes
   attr_accessor :role
 
   # Validation
   validates :username, presence: true
   validates :email, presence: true, uniqueness: { case_sensitive: false }
 
   # Define roles (client/creator)
   enum role: { client: 0, creator: 1 }

     # Define followers and following associations for both clients and creators
  has_many :followers, class_name: 'User', foreign_key: 'follower_id'
  has_many :following, class_name: 'User', foreign_key: 'following_id'
end
