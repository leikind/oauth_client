module UpdateAttribute

  require 'openssl'
  require 'net/http'

  module_function

  def update(user, key, value)

    escaped_key = CGI.escape(key)
    uri = "#{BASE_IDP_URL}/api/identities/#{user.uid}/attributes/#{escaped_key}"

    conn = Faraday.new(url: uri)

    conn.put do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{user.access_token}"
      req.body = { value: value }.to_json
    end
  end

end

__END__

curl "http://localhost:4000/api/identities/[INDIVIDUAL JURID]/attributes/email" \
  -X PATCH \
  -H "Content-Type: application/json" \
  -d '{ "value": "benjamin.peterson@gmail.com" }' \
  -H "Authorization: Bearer [INDIVIDUAL ACCESS TOKEN]"
