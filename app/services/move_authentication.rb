module MoveAuthentication

  require 'openssl'
  require 'net/http'

  module_function

  def move(from_user, to_user, auth_type, auth_uid)
    do_move(auth_type, auth_uid, from_user.access_token, to_user.access_token)
  end

  def do_move(auth_type, auth_uid, from_jurid_token, to_jurid_token)

    uri = BASE_IDP_URL + '/api/authentications'

    conn = Faraday.new(url: uri)
    conn.put do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{to_jurid_token}"
      req.body = {
        access_token_from: from_jurid_token,
        type: auth_type,
        uid: auth_uid
      }.to_json
    end

  end

end

__END__

curl -i "http://localhost:4000/api/authentications" \
   -X PUT \
   -H "Content-Type: application/json" \
   -d '{ "access_token_from": "access_token_from", "type": "google", "uid": "uid" }' \
   -H "Authorization: Bearer access_token_to"
