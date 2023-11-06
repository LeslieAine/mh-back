class Conversation < ApplicationRecord
  # belongs_to :user
  has_many :messages
  has_many :users, through: :messages

  # has many :messages
end
