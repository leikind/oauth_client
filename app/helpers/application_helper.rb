module ApplicationHelper
  def sso_sig_out_url
    BASE_JURID_URL + '/oauth/sso_signout'
  end

  def identity_count
    User.where(session_token: @session_token).count
  end

end
