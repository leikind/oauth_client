module UpdateUserAuthentications

  require 'openssl'
  require 'net/http'

  module_function

  def update(user)

    uri = BASE_JURID_URL + '/oauth/user'

    conn = Faraday.new
    resp = conn.get(uri, access_token: user.access_token)

    profile = JSON.parse(resp.body)
    # ap profile
    user.authentications = profile['authentications']
    user.save
    user
  end

end

__END__

curl -i -X GET -H "Accept: application/json" \
     "http://localhost:4000/oauth/user?access_token=eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MTk1MDIsImlhdCI6MTUzNzUzMzEwMiwiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZWRjNjhjYTUtNWE2YS00ZmQ2LWEzMDgtZmRjZjI1NWM3MTMyIiwibmJmIjoxNTM3NTMzMTAxLCJzdWIiOiIwMTM5NjE3NzYxNjk2MTMwNTU3NTc2NTE1OTM5NDk0NzZhNmY2ZDBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.hxDQ7aK416iAIy6z51HOMydZp2tFcv4wBqiveV0O93n5CehXc5Tiv_FrXpY425_3nUobnG_ot_qzLA5G_B3TTA"


curl -i -X GET  \
 "http://localhost:4000/oauth/user?access_token=eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MTk1MDIsImlhdCI6MTUzNzUzMzEwMiwiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZWRjNjhjYTUtNWE2YS00ZmQ2LWEzMDgtZmRjZjI1NWM3MTMyIiwibmJmIjoxNTM3NTMzMTAxLCJzdWIiOiIwMTM5NjE3NzYxNjk2MTMwNTU3NTc2NTE1OTM5NDk0NzZhNmY2ZDBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.hxDQ7aK416iAIy6z51HOMydZp2tFcv4wBqiveV0O93n5CehXc5Tiv_FrXpY425_3nUobnG_ot_qzLA5G_B3TTA"


