# app/controllers/favorites_controller.rb

class Api::V1::FavoritesController < ApplicationController
    before_action :authenticate_user, only: [:index, :create, :destroy]
  
    # List favorite creators for a client
    def index
      @favorites = current_user.favorite_creators
      render json: @favorites
    end
  
    # Add a creator to favorites
    def create
      creator = User.find(params[:creator_id])
  
      if current_user.client? && !current_user.favorite_creators.exists?(id: creator.id)
        current_user.favorite_creators << creator
        render json: { message: 'Creator added to favorites' }
      else
        render json: { error: 'Failed to add creator to favorites' }, status: :unprocessable_entity
      end
    end
  
    # Remove a creator from favorites
    def destroy
      creator = User.find(params[:creator_id])
  
      if current_user.client? && current_user.favorite_creators.exists?(id: creator.id)
        current_user.favorite_creators.destroy(creator)
        render json: { message: 'Creator removed from favorites' }
      else
        render json: { error: 'Failed to remove creator from favorites' }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Authentication logic (you can use a gem like Devise)
    def authenticate_user
      unless current_user
        render json: { error: 'Please log in to access this page' }, status: :unauthorized
      end
    end
  end
  