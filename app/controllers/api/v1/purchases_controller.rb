class Api::V1::PurchasesController < ApplicationController

    def purchases_by_user
        purchases = current_user.purchases
        render json: purchases, status: :ok
    end

    def purchases_on_content
        content = Content.find(params[:id])
        purchases = content.purchases
        render json: purchases, status: :ok
    end
  
    def create
      # Assume you have a method to find the content and buyer based on params
      content = Content.find(params[:content_id])
      buyer = current_user
  
      if buyer.balance >= content.price
        ActiveRecord::Base.transaction do
          begin
            # Deduct the price from the buyer's balance
            buyer.balance -= content.price
            buyer.save!
  
            # Increase the content owner's balance
            content_owner = content.user
          content_owner.balance += content.price
          content_owner.save!

          # Create the purchase record
          Purchase.create!(user: buyer, purchased_item: content, amount: content.price)
  
            render json: { message: 'Purchase successful' }, status: :created
          rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
            raise ActiveRecord::Rollback
          end
        end
      else
        render json: { error: 'Insufficient balance to make the purchase' }, status: :unprocessable_entity
      end
    end

    # private

    # def append_purchase_to_content(content, purchase)
    #     # Ensure purchases column is initialized as an empty array
    #     content.purchases ||= []

    #     # Append purchase information to content's purchases association
    #     content.purchases << {
    #     user_id: purchase.user_id,
    #     amount: purchase.amount,
    #     purchased_at: purchase.created_at
    #     }

    #     content.save!
    # end

  end
  