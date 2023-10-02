class UsersController < ApplicationController
    before_action :authenticate_user, only: [:profile, :deposit]
  
    # User registration action
    def register
      @user = User.new(user_params)
      if @user.save
        # User successfully registered, redirect to login page or perform other actions
        redirect_to login_path, notice: 'Registration successful!'
      else
        render :register
      end
    end
  
    # User login action
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        # User successfully logged in, set session or token and redirect to dashboard
        session[:user_id] = @user.id
        redirect_to dashboard_path, notice: 'Login successful!'
      else
        flash.now[:alert] = 'Invalid email or password'
        render :login
      end
    end
  
    # User profile management action
    def profile
      # Retrieve and display user profile information
      @user = current_user
    end
  
    # Deposit money into user wallet action
    def deposit
      amount = params[:amount].to_f
      if amount <= 0
        flash[:alert] = 'Invalid deposit amount'
        redirect_to profile_path
      else
        current_user.update(balance: current_user.balance + amount)
        flash[:notice] = 'Deposit successful!'
        redirect_to profile_path
      end
    end
  
    private
  
    # Strong parameters for user registration
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  
    # Authentication logic (you can use a gem like Devise)
    def authenticate_user
      unless current_user
        flash[:alert] = 'Please log in to access this page'
        redirect_to login_path
      end
    end
  end
  