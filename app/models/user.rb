class User < ApplicationRecord

  class << self

    def update_or_create(provider, uid, auth)
      if already_existing_user = User.where(provider: provider, uid: uid.to_s).first

        already_existing_user.access_token = auth['credentials']['token']
        already_existing_user.refresh_token = auth['credentials']['refresh_token']
        already_existing_user.expires_at = Time.at(auth['credentials']['expires_at']).utc

        already_existing_user.save
        already_existing_user
      else
        User.create_with_omniauth(auth)
      end
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']

        user.access_token = auth['credentials']['token']
        user.refresh_token = auth['credentials']['refresh_token']
        user.expires_at = Time.at(auth['credentials']['expires_at']).utc
      end
    end

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
