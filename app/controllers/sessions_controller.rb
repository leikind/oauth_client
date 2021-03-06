class SessionsController < ApplicationController

  def new
    redirect_to '/auth/ocapi_workplace'
  end

  def create

    auth = request.env['omniauth.auth']
    just_signed_in_user = CreateUser.update_or_create(auth['provider'], auth['uid'].to_s, auth, @session_token)

    if user_to_move_to = get_user_to_move_to(just_signed_in_user)
      MoveAllAuthenticationsOfUserToUser.move(just_signed_in_user, user_to_move_to)
      reset_move_to
      redirect_to user_url(user_to_move_to), notice: 'Authentication added!'
    else
      reset_move_to
      redirect_to user_url(just_signed_in_user), notice: 'Signed in!'
    end
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end

  private

  def reset_move_to
    session[:move_to] = nil
  end

  def get_user_to_move_to(just_signed_in_user)
    if session[:move_to] && (user = User.find_by(id: session[:move_to])) && (just_signed_in_user != user)
      user
    end
  end
end
