# frozen_string_literal: true

class Clients::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    puts "Responding with resource: #{resource.inspect}"

    return unless resource.persisted?

    current_client = Client.find(resource.id)
    token = request.env['warden-jwt_auth.token']

    render json: {
      status: { code: 200, message: 'Signed in successfully!', data: current_client, token: token }
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    current_client = Client.find(jwt_payload['sub'])

    if current_client
      render json: { status: 200, message: 'Signed out successfully!' }, status: :ok
    else
      render json: { status: 401, message: 'client has no active session!' }, status: :unauthorized
    end
  end

  def sign_in_params
    params.require(:client).permit(:username, :email, :password)
  end
end
