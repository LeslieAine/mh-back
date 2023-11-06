class Api::V1::UsersController < ApplicationController
    # skip_before_action :authenticate_user!, only: [:create]
    # before_action :authenticate_user, only: [:profile, :deposit]

    # GET /users or /users.json
    # def index
    #     @user = User.find(params[:id])
    #     @users = @user.get_users(params)
    #     render json: @users, status: :ok
    #   end

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

   # GET /api/v1/users/:id
   def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  # GET /users/new
  def new
    @user = User.new
  end


  # POST /users or /users.json
def create
    @user = User.new(user_params)

    if params[:role].present?
        @user.assign_default_role(params[:role])
      end
  
    if @user.save
      render json: @user, status: :created
    #  render json: { token: JsonWebToken.encode(sub: @user.id) }, status: created
    else
      render json: @user.errors, status: :unprocessable_entity
        # render json: { message: @user.errors.full_messages }, status: 400
    end
  end
  
#   def login
#         email = params[:user][:email]
#      password = params[:user][:password]
#     # @user = User.find_by(email: params[:email])
#     @user = User.find_by(email: email)

#     if @user&.valid_password?(password)
#       token = JsonWebToken.encode(sub: @user.id)
#       render json: { token: token }, status: :ok
#     else
#       render json: { message: 'Login failed' }, status: :unauthorized
#     end
#   end


  
  # POST /users or /users.json
#   def create
#     @user = User.new(user_params)

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

     # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_avatar
    # Find the current user (you might use a different way to find the user, e.g., authentication)
    user = User.find(params[:id])

    # Attach the uploaded avatar to the user
    if user.avatar.attach(params[:avatar])
      render json: { message: 'Avatar uploaded successfully' }
    else
      render json: { error: 'Failed to upload avatar' }, status: :unprocessable_entity
    end
  end
  
    private
  
    # Strong parameters for user registration
    def user_params
      params.require(:user).permit(:username, :email, :password, :role)
    end

    # def add_roles(resource)
    #     resource.roles = []
    #     unless params[:user][:role_ids].blank?
    #       params[:user][:role_ids].each do |role|
    #         resource.add_role Role.find(role).name
    #       end
    # end
  
    # Authentication logic (you can use a gem like Devise)
#     def authenticate_user
#       unless current_user
#         flash[:alert] = 'Please log in to access this page'
#         redirect_to login_path
#       end
#     end
  end
  