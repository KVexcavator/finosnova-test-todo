class SigninController < ApplicationController
  require 'json_web_token'
  before_action :authorize_request, except: :create

  # POST /signin
  def create
    user = User.find_by(email: params[:email].to_s)
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user_email: user.email }, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(
      :email, :password
    )
  end
end
