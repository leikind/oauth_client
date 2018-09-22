class UsersController < ApplicationController

  # before_action :authenticate_user!
  # before_action :correct_user?, except: [:index]

  def index
    @users = User.all
  end

  def refresh_authentication
    find_user
    UpdateUserAuthentications.update(@user)
    redirect_to user_path(@user)
  end

  def update_attribute
    find_user
    UpdateAttribute.update(@user, params[:key], params[:val])
    # p params[:key]
    # p params[:val]
    redirect_to user_path(@user.id, t: 2)
  end

  def show
    prepare_user_render
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def prepare_user_render
    find_user

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
