class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully', data: resource }
      }, status: :ok
    #  render json: { token: JsonWebToken.encode(sub: @user.id), data: resource }, status: created

    else
      render json: {
        status: { message: 'User could not be created', errors: resource.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :role)
  end
end
