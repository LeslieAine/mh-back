# app/controllers/transactions_controller.rb

class Api::V1::TransactionsController < ApplicationController
    # before_action :authenticate_user
  
    # Handle the purchase logic
    def purchase
      content = Content.find(params[:content_id])
      client = current_user
  
      if client.balance >= content.price
        # Client has enough balance for the purchase
        ActiveRecord::Base.transaction do
          # Deduct the purchase amount from the client's balance
          client.update(balance: client.balance - content.price)
  
          # Record the transaction
          Transaction.create(
            user_id: client.id,
            creator_id: content.creator_id,
            amount: content.price,
            transaction_type: 'purchase'
          )
        end
  
        flash[:notice] = 'Purchase successful!'
        redirect_to content_path(content), notice: 'Purchase successful!'
      else
        flash[:alert] = 'Insufficient balance for the purchase'
        redirect_to content_path(content)
      end
    end
  
    private
  
    # Authentication logic (you can use a gem like Devise)
#     def authenticate_user
#       unless current_user
#         flash[:alert] = 'Please log in to make a purchase'
#         redirect_to login_path
#       end
#     end
  end
  