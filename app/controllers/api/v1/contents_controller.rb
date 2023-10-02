# app/controllers/contents_controller.rb

class Api::V1::ContentsController < ApplicationController
    before_action :authenticate_user, except: [:index, :show]
    before_action :find_content, only: [:show]
  
    # Display a list of all available content
    def index
      @contents = Content.all
    end
  
    # Show details of a specific content item
    def show
        @content = Content.find(params[:id])
        @client = current_user if current_user.present? && current_user.client?
        @can_purchase = @client && @client.balance >= @content.price
    
        # You can add additional logic here, such as checking if the client has already purchased this content.
    
        if @content.present?
          render json: {
            content: @content,
            client: @client,
            can_purchase: @can_purchase
          }
        else
          render json: { error: 'Content not found' }, status: :not_found
        end
      end
    end
  
    # Creator's action: Create new content
    def create
      content = current_user.contents.build(content_params)
      if content.save
        flash[:notice] = 'Content created successfully!'
        redirect_to content
      else
        flash[:alert] = 'Failed to create content'
        render :new
      end
    end
  
    private
  
    # Strong parameters for content creation
    def content_params
      params.require(:content).permit(:title, :description, :price, :url)
    end
  
    # Find content by ID for show action
    def find_content
      @content = Content.find(params[:id])
    end
  
    # Authentication logic (you can use a gem like Devise)
    def authenticate_user
      unless current_user
        flash[:alert] = 'Please log in to access this page'
        redirect_to login_path
      end
    end
  end
  