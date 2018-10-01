module ApplicationHelper
  def sso_sig_out_url
    BASE_JURID_URL + '/oauth/sso_signout'
  end
end
