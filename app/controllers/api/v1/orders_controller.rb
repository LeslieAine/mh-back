class Api::V1::OrdersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_order, only: [:accept, :reject, :fulfill]

  def create
    @user = current_user
    @order = @user.orders.new(order_params)

    if @user.balance >= @order.price
      # Check if the user has enough balance
      ActiveRecord::Base.transaction do
        begin
          if @order.save
            # Deduct the order price from the ordering user's balance
            @user.balance -= @order.price
            # puts "User balance before save: #{@user.balance}"
            @user.save!
            # puts "User balance after save: #{@user.balance}"

            render json: @order, status: :created
          else
            render json: @order.errors, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { error: e.message }, status: :unprocessable_entity
          raise ActiveRecord::Rollback
        end
      end
    else
      render json: { error: 'Insufficient balance to create the order' }, status: :unprocessable_entity
    end

    # if @order.save
    #   # Deduct the order price from the ordering user's balance
    #   @user.balance -= @order.price
    #   @user.save!

    #   # @order.check_balance_and_reduce(@user)
  
    #   render json: @order, status: :created
    # else
    #   render json: @order.errors, status: :unprocessable_entity
    # end
  end

  def accept
    @order.update!(accepted_by: current_user)

    render json: @order, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
    # Implement logic to handle order acceptance
    # Move balance to the accepting user's account
    # ActiveRecord::Base.transaction do
    #   begin
    #     # Deduct the order price from the accepting user's balance
    #     current_user.balance += @order.price
    #     current_user.save!
  
    #     # Update the order to indicate acceptance
    #     @order.update!(accepted_by: current_user)
  
    #     render json: @order, status: :ok
    #   rescue StandardError => e
    #     render json: { error: e.message }, status: :unprocessable_entity
    #     raise ActiveRecord::Rollback
    #   end
    # end
  end

  def reject
    # Implement logic to handle order rejection
    # Move balance back to the ordering user's account
    ActiveRecord::Base.transaction do
      begin
        # Check if the order has already been accepted
        if @order.accepted_by.present?
          render json: { error: 'Order has already been accepted' }, status: :unprocessable_entity
        else
          # Move balance back to the ordering user's account
          @order.user.balance += @order.price
          @order.user.save!
  
          # Update the order to indicate rejection
          @order.update!(rejected_by: current_user)
  
          render json: @order, status: :ok
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def made_orders
    @user = current_user
    orders = @user.orders
    render json: orders, status: :ok
    # @user = User.find(params[:user_id])
    # @made_orders = @user.made_orders
    # render json: @made_orders
  end

  def creator_fulfilled_orders
    @user = current_user
    orders = Order.where(accepted_by_id: @user.id).where.not(fulfilled: nil)
    render json: orders, status: :ok
  end

  def client_fulfilled_orders
    @user = current_user
    orders = Order.where(ordered_by_id: @user.id).where.not(fulfilled: nil)
    render json: orders, status: :ok
  end

  def received_orders
    @user = current_user.id
    orders = Order.where(user_id: @user)
    render json: orders, status: :ok
    # @user = User.find(params[:user_id])
    # @received_orders = @user.received_orders
    # render json: @received_orders
  end

  def fulfill
    # Check if the order is accepted and owned by the current user
    if @order.accepted_by == current_user
      content = params[:content]

      # Update the order's fulfillment content
      @order.update!(fulfilled: content)

      # Perform the transaction to move balance
      ActiveRecord::Base.transaction do
        current_user.balance += @order.price
        current_user.save!
      end

      render json: @order, status: :ok
    else
      render json: { error: 'Unauthorized or order not accepted' }, status: :unauthorized
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  # def pending_orders
  #   @user = User.find(params[:user_id])
  #   @pending_orders = @user.pending_orders
  #   render json: @pending_orders
  # end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:price, :title, :description, :user_id, :length)
  end
end
