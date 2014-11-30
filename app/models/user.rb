class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :epost
  validates :epost, length: {in: 10..100}
  validates :username, length: {maximum: 26}

  def send_password_reset
    generate_token :password_reset_token
    self.password_reset_sent_at = Time.now
    self.save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token column
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
