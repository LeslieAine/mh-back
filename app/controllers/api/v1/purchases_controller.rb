class Api::V1::PurchasesController < ApplicationController
    # before_action :authenticate_user!
  
    def create
      @purchase = current_user.purchases.new(purchase_params)
  
      if @purchase.save
        render json: @purchase, status: :created
      else
        render json: @purchase.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def purchase_params
      params.require(:purchase).permit(:price, :content_id)
    end
  end