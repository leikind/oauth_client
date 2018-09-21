Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret

  if ENV['JURU']
    puts 'Authorization server: JURI Identity Engine'

    USER_INFO_URL = 'http://localhost:4000/oauth/user'

    provider :oauth2_generic,
      Rails.application.secrets.omniauth_provider_key,
      Rails.application.secrets.omniauth_provider_secret,
      client_options: {
        site: 'http://localhost:4000',
        user_info_url: USER_INFO_URL,

        authorize_url: 'http://localhost:4000/oauth/authorize',
        token_url: 'http://localhost:4000/oauth/access_token'
      },
      user_response_structure: {
        id_path: 'jurid',
        attributes: {jurid: 'jurid', authentications: 'authentications'}
      },
      name: 'ocapi_workplace',
      failure_raise_out_environments: []
  else
    puts 'Authorization server: Github'

    provider :github,
      Rails.application.secrets.omniauth_provider_key,
      Rails.application.secrets.omniauth_provider_secret

  end
end

__END__

{
  "provider" => "ocapi_workplace",
  "uid" => "i-9ZsfotyHHPAp8si2gC",
  "info" => {
    "jurid" => "i-9ZsfotyHHPAp8si2gC",
    "name" => nil
  },
  "credentials" => {
    "token" => "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1MzYzMjM3MTQsImlhdCI6MTUzNjIzNzMxNCwiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZjM5Y2U2NWUtNjRhNy00ZDI1LTk0NDAtMWUwYzBlYWQwNDc1IiwibmJmIjoxNTM2MjM3MzEzLCJzdWIiOiJpLTlac2ZvdHlISFBBcDhzaTJnQyIsInRydXN0X2xldmVsIjoyLCJ0eXAiOiJhY2Nlc3MifQ.OkQREFHuJmXIFElJ_CBxLXFdqffdLkyCIDcYBrJZu1zHoTcdsQgDfLu4GmXooy_iUfAiaf5DxI1W_P6WQePF_Q",
    "refresh_token" => "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Njc2ODY5MTQsImlhdCI6MTUzNjIzNzMxNCwiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiNmNjN2ZjYWMtZDEwMy00OGJjLWEyNmQtMTkwZDI2ODAzZGRjIiwibmJmIjoxNTM2MjM3MzEzLCJzdWIiOiJpLTlac2ZvdHlISFBBcDhzaTJnQyIsInRydXN0X2xldmVsIjoyLCJ0eXAiOiJyZWZyZXNoIn0.zxORrgt3At2KpJ5HZH4oMZ0W6unpWwtERQjDQPO_zbCoDUyxeRhc4pNw0F6-1h4FsStvGSZw40Wtn95d-cQaEg",
    "expires_at" => 1536323714,
    "expires" => true
  },
  "extra" => {
    "raw_info" => {
      "jurid" => "i-9ZsfotyHHPAp8si2gC"
    }
  }
}
