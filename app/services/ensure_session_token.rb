require 'securerandom'

module EnsureSessionToken

  module_function

  KEY = '__juru.scope__'
  LENGTH = 20

  def get(session)
    if session[KEY]
      session[KEY]
    else
      rnd = random
      session[KEY] = rnd
      rnd
    end
  end

  def random
    SecureRandom.urlsafe_base64(20).tr('lIO0', 'sxyz')
  end
end
