# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  attr_reader :password

  after_initialize :ensure_session_token

  has_many(
    :subs,
    foreign_key: :moderator_id
  )

  has_many :posts, foreign_key: :author_id

  has_many :comments, foreign_key: :author_id

  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(value)
  end

  def is_password?(attempt)
    BCrypt::Password.new(password_digest).is_password?(attempt)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    (user.is_password?(password) ? user : nil) if user
  end

  def reset_session_token!
    self.session_token = generate_session_token
    save!
    session_token
  end

  private

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
end
