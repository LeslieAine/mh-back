# class PostSerializer < ActiveModel::Serializer
#     include Rails.application.routes.url_helpers
#     attributes :id, :content, :user_id, :image_url
  
#     def image_url
#       if object.image.attached?
#         rails_blob_url(object.image, only_path: true)
#       end
#     end
#   end