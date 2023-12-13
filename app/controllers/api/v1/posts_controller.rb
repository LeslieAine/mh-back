class Api::V1::PostsController < ApplicationController
        # before_action :authenticate_user, only: [:create]
        before_action :find_post, only: [:show, :destroy]
        load_and_authorize_resource
        
        def index
            @posts = Post.includes(:user).with_attached_image.order(created_at: :desc)
            render json: @posts.to_json(
                include: {
                     user: { only: [:id, :username, :avatar] },
                    },
                    methods: [:image_url]
                    )
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

         # Attach the image if present in the params
        # @post.image.attach(params[:image]) if params[:image].present?
        # post.main_photo.attach(params[:main_photo]) if params[:main_photo]
        if params[:image] #changed this to image from file.
            post.image.attach(params[:image]) #changed this to image from file.
            image_url = url_for(post.image)
          end


        if @post.save
            render json: @post, status: :created
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
        end
    end
    
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
        params.require(:post).permit(:content, :user_id, :image)
        end
    
        # Authentication logic (you can use a gem like Devise)
        # def authenticate_user
        #   unless current_user
        #     render json: { error: 'Please log in to perform this action' }, status: :unauthorized
        #   end
        # end
    end
    