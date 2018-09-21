module MoveAuthentication

  require 'openssl'
  require 'net/http'

  module_function

  def move(from_user, to_user, auth_type, auth_uid)
    do_move(from_user.uid, to_user.uid, auth_type, auth_uid, from_user.access_token, to_user.access_token)
  end

  def do_move(from_jurid, to_jurid, auth_type, auth_uid, from_jurid_token, to_jurid_token)

    uri = BASE_JURID_URL + '/api/identities/' + from_jurid + '/authentications'

    conn = Faraday.new(url: uri)
    conn.put do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{from_jurid_token}"
      req.headers['J-Authorization'] = "Bearer #{to_jurid_token}"
      req.body = { to: to_jurid, uid: auth_uid, type: auth_type }.to_json
    end

  end

end

__END__


MoveAuthentication.do_move("01396177726f4e3754525a7850385a736262730f", "013961777273335347557933744a354d5166670f", "google", "108644613428037583090", "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2Mjk4NjMsImlhdCI6MTUzNzU0MzQ2MywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiYTNkNGYxNTgtZDdlYS00YzJlLTkwNmQtYWNkMzk3YTRhODI4IiwibmJmIjoxNTM3NTQzNDYyLCJzdWIiOiIwMTM5NjE3NzcyNmY0ZTM3NTQ1MjVhNzg1MDM4NWE3MzYyNjI3MzBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.x70txLe-FsGmR0LhV21Ty73Dnbx1jKZlGSFtLJcsfq05_gmmLiJTrkxSImCbZFmBMGuLbJTRsrgUI3hs2HepHg", "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2Mjk5MDMsImlhdCI6MTUzNzU0MzUwMywiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiN2JmNzM3ZTctMzI1ZS00ZjliLTg1ZDYtNTU3NmVlOWVjYTk1IiwibmJmIjoxNTM3NTQzNTAyLCJzdWIiOiIwMTM5NjE3NzcyNzMzMzUzNDc1NTc5MzM3NDRhMzU0ZDUxNjY2NzBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.mWpYx15YQ9W0Ml4_ZvP2TAvZGHpeAUFvuIvzyaq_davPD-KgLIZztUGv1xpTW8H4GJUmUxrNGjXsvZIzvsBPmw")


curl -i "http://localhost:4000/api/identities/0139617761655a626d5351495a6b6f6e5572510f/authentications" \
   -X PUT \
   -H "Content-Type: application/json" \
   -d '{ "to": "013961776169613055757651593949476a6f6d0f", "uid": "108644613428037583090", "type": "google" }' \
   -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MTgzMzAsImlhdCI6MTUzNzUzMTkzMCwiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiMDAxODYwYTktNTk5Yi00YTIyLWI1ZTUtYjAwMmQ4ZDgwZjllIiwibmJmIjoxNTM3NTMxOTI5LCJzdWIiOiIwMTM5NjE3NzYxNjU1YTYyNmQ1MzUxNDk1YTZiNmY2ZTU1NzI1MTBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.RV5JWtWiObtaLqdSTl3VLHshxzsRbUIEv3uphkmRwH02UnK8RfSXlaqmZt25ZTn7Ege_rCr5hwL4G9_bUKkj4g" \
   -H "J-Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKdXJ1IENvcmUiLCJleHAiOjE1Mzc2MTgzNzEsImlhdCI6MTUzNzUzMTk3MSwiaXNzIjoiSnVydSBDb3JlIiwianRpIjoiYWM4ODJkNmQtN2NkNi00N2RhLTgwODYtZGE3NjE0YjVmZDk3IiwibmJmIjoxNTM3NTMxOTcwLCJzdWIiOiIwMTM5NjE3NzYxNjk2MTMwNTU3NTc2NTE1OTM5NDk0NzZhNmY2ZDBmIiwidHJ1c3RfbGV2ZWwiOjUsInR5cCI6ImFjY2VzcyJ9.SPJ_FGSsm7s6rF-OGozy5e3ViegOjwqj8jMnsOdWN4jEPboNK5JrZWUvt57bFlo2WkUcfoPHXQoZSa2rUuat8g"
