class User < ActiveRecord::Base
  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, { presence: true, uniqueness: { case_sensitive: false } }
  validates :password_digest, length: { minimum: 6 }
end