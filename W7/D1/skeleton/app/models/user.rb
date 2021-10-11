class User < ApplicationRecord

  attr_reader :password
  validates :password, allow_nil: true, length: { minimum: 6, too_short: "Password must be at least six characters" }
  after_initialize :reset_session_token!

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_valid_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_valid_password?(password)
    password_object = BCrypt::Password.new(self.password_digest)
    password_object.is_password?(password)
  end
end
