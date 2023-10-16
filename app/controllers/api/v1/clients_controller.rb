class Api::V1::ClientsController < ApplicationController
    # before_action :authenticate_user, only: [:profile, :deposit]

    # GET /users or /users.json
  def index
    @clients = Client.all
  end

  # GET /api/v1/users
#   def index
#     @users = User.all
#     render json: @users, status: :ok
#   end

   # GET /api/v1/users/:id
   def show
    # @user = User.find(params[:id])
    # render json: @user, status: :ok
  end

  # GET /users/new
  def new
    @client = Client.new
  end


  # POST /users or /users.json
def create
    @client = Client.new(user_params)
  
    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end
  
  
  # POST /clients or /clients.json
#   def create
#     @client = client.new(client_params)

#     respond_to do |format|
#       if @user.save
#         format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
#         format.json { render :show, status: :created, location: @user }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @user.errors, status: :unprocessable_entity }
#       end
#     end
#   end
  
    # User registration action
    # def register
    #   @user = User.new(user_params)
    #   if @user.save
    #     # User successfully registered, redirect to login page or perform other actions
    #     redirect_to login_path, notice: 'Registration successful!'
    #   else
    #     render :register
    #   end
    # end
  
    # # User login action
    # def login
    #   @user = User.find_by(email: params[:email])
    #   if @user && @user.authenticate(params[:password])
    #     # User successfully logged in, set session or token and redirect to dashboard
    #     session[:user_id] = @user.id
    #     redirect_to dashboard_path, notice: 'Login successful!'
    #   else
    #     flash.now[:alert] = 'Invalid email or password'
    #     render :login
    #   end
    # end
  
    # User profile management action
    def profile
      # Retrieve and display user profile information
      @client = current_client
    end
  
    # Deposit money into client wallet action
    def deposit
      amount = params[:amount].to_f
      if amount <= 0
        flash[:alert] = 'Invalid deposit amount'
        redirect_to profile_path
      else
        current_client.update(balance: current_client.balance + amount)
        flash[:notice] = 'Deposit successful!'
        redirect_to profile_path
      end
    end

     # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_avatar
    # Find the current user (you might use a different way to find the user, e.g., authentication)
    client = Client.find(params[:id])

    # Attach the uploaded avatar to the user
    if client.avatar.attach(params[:avatar])
      render json: { message: 'Avatar uploaded successfully' }
    else
      render json: { error: 'Failed to upload avatar' }, status: :unprocessable_entity
    end
  end
  
    private
  
    # Strong parameters for client registration
    def client_params
      params.require(:client).permit(:username, :email, :password, :role)
    end
  
    # Authentication logic (you can use a gem like Devise)
#     def authenticate_user
#       unless current_user
#         flash[:alert] = 'Please log in to access this page'
#         redirect_to login_path
#       end
#     end
  end
  