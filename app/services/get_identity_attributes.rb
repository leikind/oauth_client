module GetIdentityAttributes

  require 'openssl'
  require 'net/http'

  module_function

  def get(user)

    uri = BASE_JURID_URL + '/api/identities/' + user.uid + '/attributes'

    conn = Faraday.new(url: uri)
    resp = conn.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{user.access_token}"
    end

    JSON.parse(resp.body)
  end

end

__END__

curl -i "http://localhost:4000/api/identities/013961777273335347557933744a354d5166670f/attributes" \
  -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MzMxNTMsImlhdCI6MTUzNzU0Njc1MywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZjYzNzljNjQtZjlkMy00ZDM5LTgyZDMtMmZkMWU2ZjY1MDAzIiwibmJmIjoxNTM3NTQ2NzUyLCJzdWIiOiIwMTM5NjE3NzcyNzMzMzUzNDc1NTc5MzM3NDRhMzU0ZDUxNjY2NzBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.uS1Oq7kQ7TLddJdU981BZi5K7El1OpQLYK6I-kypdPtnAL01SbTKWk8gGCP3KSOflXI5jVaaAApK0HUuo3F5IA"


curl "http://localhost:4000/api/identities/013961777273335347557933744a354d5166670f/attributes/email" \
  -X PATCH \
  -H "Content-Type: application/json" \
  -d '{ "value": "benjamin.peterson@gmail.com" }' \
  -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MzMxNTMsImlhdCI6MTUzNzU0Njc1MywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZjYzNzljNjQtZjlkMy00ZDM5LTgyZDMtMmZkMWU2ZjY1MDAzIiwibmJmIjoxNTM3NTQ2NzUyLCJzdWIiOiIwMTM5NjE3NzcyNzMzMzUzNDc1NTc5MzM3NDRhMzU0ZDUxNjY2NzBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.uS1Oq7kQ7TLddJdU981BZi5K7El1OpQLYK6I-kypdPtnAL01SbTKWk8gGCP3KSOflXI5jVaaAApK0HUuo3F5IA"

curl "http://localhost:4000/api/identities/013961777273335347557933744a354d5166670f/attributes/age" \
  -X PATCH \
  -H "Content-Type: application/json" \
  -d '{ "value": "32" }' \
  -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MzMxNTMsImlhdCI6MTUzNzU0Njc1MywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiZjYzNzljNjQtZjlkMy00ZDM5LTgyZDMtMmZkMWU2ZjY1MDAzIiwibmJmIjoxNTM3NTQ2NzUyLCJzdWIiOiIwMTM5NjE3NzcyNzMzMzUzNDc1NTc5MzM3NDRhMzU0ZDUxNjY2NzBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.uS1Oq7kQ7TLddJdU981BZi5K7El1OpQLYK6I-kypdPtnAL01SbTKWk8gGCP3KSOflXI5jVaaAApK0HUuo3F5IA"
