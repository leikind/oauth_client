class SessionsController < ApplicationController

  def new
    redirect_to(ENV['JURU'] ? '/auth/ocapi_workplace' : '/auth/github')
  end

  def create
    auth = request.env['omniauth.auth']
    user = CreateUser.update_or_create(auth['provider'], auth['uid'].to_s, auth)
    reset_session
    session[:user_id] = user.id
    redirect_to user_url(user), notice: 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end

end
