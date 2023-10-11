# frozen_string_literal: true

# class Users::Registrations::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
# end

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    render json: {
      status: { code: 200, message: 'Signed in successfully!', data: current_user }
    }, status: :ok
  end

  # DELETE /users/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render json: { status: 200, message: 'Signed out successfully!' }, status: :ok
    else
      render json: { status: 401, message: 'User has no active session!' }, status: :unauthorized
    end
  end

  private

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end

