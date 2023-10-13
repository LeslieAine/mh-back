# app/controllers/bookmarks_controller.rb

class Api::V1::BookmarksController < ApplicationController
    # before_action :authenticate_user
    before_action :find_post, only: [:create, :destroy]
  
    # Create a bookmark for a post
    def create
      if current_user.client?
        # Check if the client has already bookmarked the post
        if current_user.bookmarks.exists?(post_id: @post.id)
          render json: { message: 'You have already bookmarked this post' }, status: :unprocessable_entity
        else
          # Create a new bookmark
          bookmark = current_user.bookmarks.build(post_id: @post.id)
          if bookmark.save
            render json: { message: 'Post bookmarked' }
          else
            render json: { error: 'Failed to bookmark the post' }, status: :unprocessable_entity
          end
        end
      else
        render json: { error: 'Only clients can bookmark posts' }, status: :forbidden
      end
    end
  
    # List bookmarks for the current client
    def index
      @bookmarks = current_user.bookmarks
      render json: @bookmarks
    end
  
    # Remove a bookmark for a post
    def destroy
      if current_user.client?
        # Find and destroy the bookmark
        bookmark = current_user.bookmarks.find_by(post_id: @post.id)
        if bookmark
          bookmark.destroy
          render json: { message: 'Post unbookmarked' }
        else
          render json: { error: 'You have not bookmarked this post' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Only clients can remove bookmarks' }, status: :forbidden
      end
    end
  
    private
  
    # Find the post by ID
    def find_post
      @post = Post.find(params[:post_id])
    end
  
    # Authentication logic (you can use a gem like Devise)
    # def authenticate_user
    #   unless current_user
    #     render json: { error: 'Please log in to perform this action' }, status: :unauthorized
    #   end
    # end
  end
  