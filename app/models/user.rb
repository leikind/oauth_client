class User < ApplicationRecord

  serialize :authentications, JSON

  class << self

    def update_or_create(provider, uid, auth)

      if already_existing_user = User.where(provider: provider, uid: uid.to_s).first
        update_fields(already_existing_user, auth)
        already_existing_user.save
        already_existing_user
      else
        create! do |user|
          user.provider = auth['provider']
          user.uid = auth['uid']
          update_fields(user, auth)
        end
      end
    end

    def update_fields(user, auth)
      user.access_token = auth['credentials']['token']
      user.refresh_token = auth['credentials']['refresh_token']
      user.expires_at = Time.at(auth['credentials']['expires_at']).utc
      user.authentications = auth['info']['authentications']
    end
  end
end

__END__
{
  "provider" => "ocapi_workplace",
  "uid" => "01396174446b36543870534c65684a587043340f",
  "info" => {
    "jurid" => "01396174446b36543870534c65684a587043340f",
    "authentications" => [
      {
        "uid" => "108644613428037583090",
        "type" => "google"
      }
    ],
    "name" => nil
  },
  "credentials" => {
    "token" => "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc1NDEzMjcsImlhdCI6MTUzNzQ1NDkyNywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZTdiMzI1NDYtZDU5ZC00NzY1LWE0ZjUtNmUyYjM4MjcyOWU1IiwibmJmIjoxNTM3NDU0OTI2LCJzdWIiOiIwMTM5NjE3NDQ0NmIzNjU0Mzg3MDUzNGM2NTY4NGE1ODcwNDMzNDBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.2Aoh1xEQbUovTPf0nlErEpVsfIujUWBE-EDJ91usnkLN2HSgEpM_BKJLaqg3IyY4FP1ggF5Cdsbk4HkPQbNs5w",
    "refresh_token" => "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Njg5MDQ1MjcsImlhdCI6MTUzNzQ1NDkyNywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiYWM0NmNkNTQtYTUwNy00YjcwLWJlOGYtNDA1OTBlNzk4MmIxIiwibmJmIjoxNTM3NDU0OTI2LCJzdWIiOiIwMTM5NjE3NDQ0NmIzNjU0Mzg3MDUzNGM2NTY4NGE1ODcwNDMzNDBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6InJlZnJlc2gifQ.kHfovGZfVxOyXcE8Pik97cEd5CkTTNL3_CzBzW00bP183EB5Jqp0-76CAIzPnxAX50Juhyhgk_D9P2jyEUIFxA",
    "expires_at" => 1537541327,
    "expires" => true
  },
  "extra" => {
    "raw_info" => {
      "uid" => "01396174446b36543870534c65684a587043340f",
      "jurid" => "01396174446b36543870534c65684a587043340f",
      "authentications" => [
        {
          "uid" => "108644613428037583090",
          "type" => "google"
        }
      ]
    }
  }
}
