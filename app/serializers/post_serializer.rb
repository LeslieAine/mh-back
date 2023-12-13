class PostSerializer < ActiveModel::Serializer
    # include JSONAPI::Serializer
    include Rails.application.routes.url_helpers
    attributes :id, :content, :user_id, :image, :image_url

    # belongs_to :user
    # has_one_attached :image

    def image
        return unless object.image.attached?
    
        object.image.blob.attributes
              .slice('filename', 'byte_size')
              .merge(url: image_url)
              .tap { |attrs| attrs['name'] = attrs.delete('filename') }
      end

    # def image
    #     blob = ActiveStorage::Blob.create_after_upload!(
    #       io: params[:file],
    #       filename: params[:file].original_filename,
    #       content_type: params[:file].content_type
    #     )
    
    #     render json: { filelink: url_for(blob) }
    #   end
    
    #   def image_url
    #     url_for(object.image)
    #   end
    
    # def image_url
    #     rails_blob_path(object.image, only_path: true) if object.image.attached?
    # end
    # def image_data_attachment_url
    #     {
    #       id: object.image_data.id,
    #       service_url: Rails.application.routes.url_helpers.rails_blob_path(object.image_data, only_path: true)
    #     }
    #   end

  end
  