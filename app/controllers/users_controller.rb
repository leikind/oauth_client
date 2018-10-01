class UsersController < ApplicationController

  before_action :find_user, except: :index
  # before_action :authenticate_user!
  # before_action :correct_user?, except: [:index]

  def index
    @users = User.where(session_token: @session_token).all
  end

  def refresh_authentication
    UpdateUserAuthentications.update(@user)
    redirect_to user_path(@user), notice: 'Authentications updated'
  end

  def update_attribute
    UpdateAttribute.update(@user, params[:key], params[:val])
    redirect_to user_path(@user.id, t: 2), notice: 'Attribute updated'
  end

  def move_authentication_to
    session[:move_to] = @user.id
    redirect_to signin_path
  end

  def show
    prepare_user_render
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'Deleted'
  end

  private

  def find_user
    unless @user = User.where(session_token: @session_token, id: params[:id]).first
      redirect_to users_path
      return false
    end
  end

  def prepare_user_render
    @active_tab = params['t'] ? params['t'].to_i : 1
    @active_tab = 1 unless [1, 2, 3, 4].index(@active_tab)

    header_header_access, payload_string_access, _signature   = @user.access_token.split('.')
    header_header_refresh, payload_string_refresh, _signature = @user.refresh_token.split('.')

    @payload_access = JSON.parse(Base64.decode64(payload_string_access))
    @header_access  = JSON.parse(Base64.decode64(header_header_access))

    @payload_refresh = JSON.parse(Base64.decode64(payload_string_refresh))
    @header_refresh  = JSON.parse(Base64.decode64(header_header_refresh))

    @access_token_expires_at = Time.at(@payload_access['exp']).utc
    @refresh_token_expires_at = Time.at(@payload_refresh['exp']).utc

    @trust_level = @payload_access['trust_level']

    @attributes = GetIdentityAttributes.get(@user)
  end
end
