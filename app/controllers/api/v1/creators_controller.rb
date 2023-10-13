class Api::V1::CreatorsController < ApplicationController
    # before_action :authenticate_user, only: [:profile, :deposit]

    # GET /users or /users.json
  def index
    @creators = Creator.all
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
    @creator = Creator.new
  end


  # POST /users or /users.json
def create
    @creator = Creator.new(user_params)
  
    if @creator.save
      render json: @creator, status: :created
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end
  
  
  # POST /creators or /creators.json
#   def create
#     @creator = creator.new(creator_params)

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
      @creator = current_creator
    end
  
    # Deposit money into creator wallet action
    def deposit
      amount = params[:amount].to_f
      if amount <= 0
        flash[:alert] = 'Invalid deposit amount'
        redirect_to profile_path
      else
        current_creator.update(balance: current_creator.balance + amount)
        flash[:notice] = 'Deposit successful!'
        redirect_to profile_path
      end
    end

     # DELETE /creators/1 or /creators/1.json
  def destroy
    @creator.destroy

    respond_to do |format|
      format.html { redirect_to creators_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_avatar
    # Find the current user (you might use a different way to find the user, e.g., authentication)
    creator = Creator.find(params[:id])

    # Attach the uploaded avatar to the user
    if creator.avatar.attach(params[:avatar])
      render json: { message: 'Avatar uploaded successfully' }
    else
      render json: { error: 'Failed to upload avatar' }, status: :unprocessable_entity
    end
  end
  
    private
  
    # Strong parameters for creator registration
    def creator_params
      params.require(:creator).permit(:username, :email, :password, :role)
    end
  
    # Authentication logic (you can use a gem like Devise)
#     def authenticate_user
#       unless current_user
#         flash[:alert] = 'Please log in to access this page'
#         redirect_to login_path
#       end
#     end
  end
  