class UsersController < ApplicationController

  # before_action :authenticate_user!
  # before_action :correct_user?, except: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    header_header_access, payload_string_access, _signature   = @user.access_token.split('.')
    header_header_refresh, payload_string_refresh, _signature = @user.refresh_token.split('.')

    @payload_access = JSON.parse(Base64.decode64(payload_string_access))
    @header_access  = JSON.parse(Base64.decode64(header_header_access))

    @payload_refresh = JSON.parse(Base64.decode64(payload_string_refresh))
    @header_refresh  = JSON.parse(Base64.decode64(header_header_refresh))

    @access_token_expires_at = Time.at(@payload_access['exp']).utc
    @refresh_token_expires_at = Time.at(@payload_refresh['exp']).utc

    @trust_level = @payload_access['trust_level']
  end
end
