    class Api::V1::PostsController < ApplicationController
        # before_action :authenticate_user, only: [:create]
        before_action :find_post, only: [:show, :destroy]
        load_and_authorize_resource
    
        # Retrieve a list of all posts
        # def index
        #     render json: Post.all.order(created_at: :desc)
        #     # @posts = Post.all
        #     # render json: @posts
        # end
    
        # Show details of a specific post
        # def show
        # @post = Post.find(params[:id])
        # render json: @post
        # end

        # def show
        #     @post = Post.find_by(id: params[:id])
        
        #     if @post
        #       render json: @post
        #     else
        #       render json: { error: 'Post not found' }, status: :not_found
        #     end
        #   end
        
        def index
            @posts = Post.includes(:user).order(created_at: :desc)
            render json: @posts.to_json(include: { user: { only: [:id, :username, :avatar] } })
          end
    
          def show
            @post = Post.includes(:user).find_by(id: params[:id])
    
            if @post
              render json: @post.to_json(include: { user: { only: [:id, :username, :avatar] } })
            else
              render json: { error: 'Post not found' }, status: :not_found
            end
          end

        # Create a new post (for users)
        def create
            # puts "Received params: #{params.inspect}"
            # @user = User.find_by(id: params[:user_id])
            @user = current_user

        if @user.nil?
            render json: { error: 'User not found' }, status: :unprocessable_entity
        else


        @post = @user.posts.build(post_params)

        # if params[:post][:image].present?
        #     image_data = params[:post][:image]
        #     image_io = StringIO.new(Base64.decode64(image_data["data"]))
        #     image_io.class.class_eval { attr_accessor :original_filename, :content_type }
        #     image_io.original_filename = image_data["filename"]
        #     image_io.content_type = image_data["content_type"]

        #     @post.image.attach(io: image_io, filename: image_io.original_filename)
        # end
        # @post.image.attach(params[:image]) if params[:image].present?
        # Attach the image if present in the nested structure
        # if params.dig(:post, :image).present?
        #     @post.image.attach(params[:post][:image])
        # end

        if @post.save
            render json: @post, status: :created
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
        end
    end
    
        # Other actions (e.g., liking and bookmarking posts) can be added here
        # Like a post
    #   def like
    #     @post = Post.find(params[:id])
    #     @client = current_user if current_user.present? && current_user.client?

    #     if @client.present?
    #       # Check if the client has already liked the post
    #       if @client.likes.exists?(post_id: @post.id)
    #         # Client has already liked the post, so we can assume this action unlikes the post
    #         @client.likes.find_by(post_id: @post.id).destroy
    #         render json: { message: 'Post unliked' }
    #       else
    #         # Client hasn't liked the post, so we create a new like
    #         @client.likes.create(post_id: @post.id)
    #         render json: { message: 'Post liked' }
    #       end
    #     else
    #       render json: { error: 'Only clients can like posts' }, status: :forbidden
    #     end
    #   end

    #   # Bookmark a post
    #   def bookmark
    #     @post = Post.find(params[:id])
    #     @client = current_user if current_user.present? && current_user.client?

    #     if @client.present?
    #       # Check if the client has already bookmarked the post
    #       if @client.bookmarks.exists?(post_id: @post.id)
    #         # Client has already bookmarked the post, so this action removes the bookmark
    #         @client.bookmarks.find_by(post_id: @post.id).destroy
    #         render json: { message: 'Post unbookmarked' }
    #       else
    #         # Client hasn't bookmarked the post, so we create a new bookmark
    #         @client.bookmarks.create(post_id: @post.id)
    #         render json: { message: 'Post bookmarked' }
    #       end
    #     else
    #       render json: { error: 'Only clients can bookmark posts' }, status: :forbidden
    #     end
    #   end

        # DELETE /api/v1/posts/:id
    def destroy
        if current_user? && @post.user == current_user
        @post.destroy
        render json: { message: 'Post deleted successfully' }
        else
        render json: { error: 'You are not authorized to delete this post' }, status: :forbidden
        end
    end

    # def show
    #     @post = Post.find_by(id: params[:id])
    
    #     if @post
    #       render json: @post
    #     else
    #       render json: { error: 'Post not found' }, status: :not_found
    #     end
    #   end
    
        private
    
        # Strong parameters for post creation

        # Find the post by ID
    def find_post
        @post = Post.find(params[:id])
    end
    
        def post_params
        params.require(:post).permit(:content, :user_id, image: {})
        end
    
        # Authentication logic (you can use a gem like Devise)
        # def authenticate_user
        #   unless current_user
        #     render json: { error: 'Please log in to perform this action' }, status: :unauthorized
        #   end
        # end
    end
    