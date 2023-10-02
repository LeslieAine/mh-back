# app/controllers/posts_controller.rb

class Api::V1::PostsController < ApplicationController
    before_action :authenticate_user, only: [:create]
  
    # Retrieve a list of all posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # Show details of a specific post
    def show
      @post = Post.find(params[:id])
      render json: @post
    end
  
    # Create a new post (for creators)
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        render json: @post, status: :created
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
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
  
    private
  
    # Strong parameters for post creation
    def post_params
      params.require(:post).permit(:content)
    end
  
    # Authentication logic (you can use a gem like Devise)
    def authenticate_user
      unless current_user
        render json: { error: 'Please log in to perform this action' }, status: :unauthorized
      end
    end
  end
  