class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)
  # belongs_to :user #class_name: 'Creator', foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'user_id'
  has_many :bookmarks
  has_many :likes

  # has_one_attached :image

  # Validations
  validates :content, presence: true

  # serialize :likes, Array
end
