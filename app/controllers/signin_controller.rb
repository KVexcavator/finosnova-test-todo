class SigninController < ApplicationController
  require 'json_web_token'
  before_action :authorize_request, except: :create
  before_action :set_current_user_exp

  # POST /signin
  def create
    user = User.find_by(email: params[:email].to_s)
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode({user_id: user.id})
      session[:current_user_token] = token
      time = session[:current_user_exp]
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user_email: user.email }, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  def reset
    reset_session
  end

  def destroy
    session.delete(:current_user_token)
    @current_user = nil
    render json: :ok
  end

  private

  def set_current_user_exp
    if session[:current_user_exp] && session[:current_user_exp] < (Time.now - 12.hours.to_i)
      time_exp=session[:current_user_exp]
    else
      time_exp = Time.now + 24.hours.to_i
    end
    session[:current_user_exp]=time_exp
  end

  def user_params
    params.permit(
      :email, :password
    )
  end
end
