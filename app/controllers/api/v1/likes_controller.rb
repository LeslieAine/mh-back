# app/controllers/likes_controller.rb

class LikesController < ApplicationController
    before_action :authenticate_user
    before_action :find_post, only: [:create, :destroy]
  
    # Like a post
    def create
      if current_user.client?
        # Check if the client has already liked the post
        if @post.likes.exists?(user_id: current_user.id)
          render json: { message: 'You have already liked this post' }, status: :unprocessable_entity
        else
          # Create a new like
          like = @post.likes.build(user_id: current_user.id)
          if like.save
            render json: { message: 'Post liked' }
          else
            render json: { error: 'Failed to like the post' }, status: :unprocessable_entity
          end
        end
      else
        render json: { error: 'Only clients can like posts' }, status: :forbidden
      end
    end
  
    # Unlike a post
    def destroy
      if current_user.client?
        # Find and destroy the like
        like = @post.likes.find_by(user_id: current_user.id)
        if like
          like.destroy
          render json: { message: 'Post unliked' }
        else
          render json: { error: 'You have not liked this post' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Only clients can unlike posts' }, status: :forbidden
      end
    end
  
    private
  
    # Find the post by ID
    def find_post
      @post = Post.find(params[:post_id])
    end
  
    # Authentication logic (you can use a gem like Devise)
    def authenticate_user
      unless current_user
        render json: { error: 'Please log in to perform this action' }, status: :unauthorized
      end
    end
  end
  