# app/controllers/abouts_controller.rb
class Api::V1::AboutsController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_about, only: [:show, :edit, :update]
  
    # def show
    #   # Retrieve and display the user's profile
    #     user = User.find(params[:user_id])
    #     # @about = user.about
    #     @about = user.about || About.new(description: 'No description yet', interests: 'No interests yet', intentions: 'No intentions yet')
    #     render json: @about, status: :ok
    # end
    def show
        user = User.find(params[:user_id])
        
        if user.about.blank?
          # If user.about is empty, create a new About object with default values
          @about = About.new(description: 'No description yet', interests: 'No interests yet', intentions: 'No intentions yet')
        else
          @about = user.about
        end
      
        render json: @about, status: :ok
      end
      
  
    def edit
      # Render the form to edit the user's about
    end
  
    def update
      # Update the user's about with the submitted data
      if @about.update(about_params)
        render json: @about, status: :ok
      else
        render json: @about.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_about
      @about = current_user.about || current_user.build_about
    end
  
    def about_params
      params.require(:about).permit(:description, :interests, :intentions)
    end
  end
  