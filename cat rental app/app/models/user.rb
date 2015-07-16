class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  attr_reader :password

  has_many(
    :cats,
    class_name: 'Cat'
  )

  has_many(
    :requests,
    class_name: 'CatRentalRequest',
    foreign_key: :user_id,
    inverse_of: :requester
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end
