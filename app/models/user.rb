class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :epost
  validates :epost, length: {in: 10..100}
  validates :username, length: {maximum: 26}

end
