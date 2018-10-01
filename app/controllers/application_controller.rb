class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # http_basic_authenticate_with(
  #   name: Rails.application.secrets.http_basic_authentication_name,
  #   password: Rails.application.secrets.http_basic_authentication_password
  # )

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  before_action :ensure_session_token

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue Exception => _e
    nil
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, alert: 'Access denied.'
    end
  end

  def authenticate_user!
    unless current_user
      redirect_to root_url, alert: 'You need to sign in for access to this page.'
    end
  end

  def ensure_session_token
    @session_token = EnsureSessionToken.get(session)
  end

end
