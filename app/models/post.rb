class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  # belongs_to :user #class_name: 'Creator', foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'user_id'
  has_many :bookmarks
  has_many :likes

  # Validations
  validates :content, presence: true

  # serialize :likes, Array
end
