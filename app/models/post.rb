class Post < ApplicationRecord
  # belongs_to :user #class_name: 'Creator', foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'user_id'
  has_many :bookmarks
  has_many :likes

  # has_one_attached :main_photo

  # has_many_attached :images
  has_one_attached :image

  # def image_url
  #   Rails.application.routes.url_helpers.url_for(image) if image.attached?
  # end

  def image_url
    Rails.application.routes.url_helpers.rails_blob_path(self.image, only_path: true) if self.image.attached?
  end

  # validate :valid_image

  # def valid_image
  #   return unless main_photo.attached?

  #   unless main_photo.blob.byte_size <= 1.megabyte
  #     errors.add(:main_photo, "The image is more than 1MB")
  #   end
  # end

  # def image_url
  #   Rails.application.routes.url_helpers.url_for(image) if image.attached?
  # end

  # def image
  #       return unless object.image.attached?
    
  #       object.image.blob.attributes
  #             .slice('filename', 'byte_size')
  #             .merge(url: image_url)
  #             .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  #     end
    
  #     def image_url
  #       url_for(object.image)
  #     end

  # def image_url
  #   Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.attached?
  # end

  # Validations
  validates :content, presence: true

  # serialize :likes, Array
end
