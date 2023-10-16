# app/controllers/contents_controller.rb

class Api::V1::ContentsController < ApplicationController
    # before_action :authenticate_user, except: [:index, :show]
    before_action :find_content, only: [:show]
  
    # Display a list of all available content
    def index
      @contents = Content.includes(:creator).order(created_at: :desc)
      render json: @contents.to_json(include: { creator: { only: [:id, :username, :avatar] } })
    end
  
    # Show details of a specific content item
    def show
        # @content = Content.find(params[:id])
        @content = Content.includes(:creator).find_by(id: params[:id])
        if @content
            render json: @content.to_json(include: { creator: { only: [:id, :username, :avatar] } })
          else
            render json: { error: 'Content not found' }, status: :not_found
          end
        # @client = current_client
        # @can_purchase = @client && @client.balance >= @content.price
    
        # You can add additional logic here, such as checking if the client has already purchased this content.
    
    #     if @content.present?
    #       render json: {
    #         content: @content,
    #         client: @client,
    #         can_purchase: @can_purchase
    #       }
    #     else
    #       render json: { error: 'Content not found' }, status: :not_found
    #     end
    #   end
    end
  
    # Creator's action: Create new content
    def create
        @creator = current_creator

        if @creator.nil?
            render json: { error: 'User not found' }, status: :unprocessable_entity
        else


        @post = @creator.contents.build(content_params)
        if @post.save
            render json: @post, status: :created
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
        end
    end
  
    private
  
    # Strong parameters for content creation
    def content_params
      params.require(:content).permit(:title, :description, :price, :url, :creator_id, :isPaid)
    end
  
    # Find content by ID for show action
    def find_content
      @content = Content.find(params[:id])
    end
  
    # Authentication logic (you can use a gem like Devise)
    # def authenticate_user
    #   unless current_user
    #     flash[:alert] = 'Please log in to access this page'
    #     redirect_to login_path
    #   end
    # end
  end
  