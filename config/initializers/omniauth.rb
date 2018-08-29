Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret

  if ENV['JURU']
    puts 'Authorization server: JURI Identity Engine'

    provider :oauth2_generic,
      Rails.application.secrets.omniauth_provider_key,
      Rails.application.secrets.omniauth_provider_secret,
      client_options: {
        site: 'http://localhost:4000',
        user_info_url: 'http://localhost:4000/oauth/user',

        authorize_url: 'http://localhost:4000/oauth/authorize',
        token_url: 'http://localhost:4000/oauth/access_token'
      },
      user_response_structure: {
        root_path: ['identity_id', 'email_address']
      },
      name: 'superclient',
      failure_raise_out_environments: []
  else
    puts 'Authorization server: Github'

    provider :github,
      Rails.application.secrets.omniauth_provider_key,
      Rails.application.secrets.omniauth_provider_secret

  end
end
