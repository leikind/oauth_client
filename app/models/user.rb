class User < ApplicationRecord

  serialize :authentications, JSON

end
