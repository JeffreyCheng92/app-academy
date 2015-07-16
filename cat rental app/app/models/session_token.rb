class SessionToken < ActiveRecord::Base
  validates :user_id, :token, presence: true
  validates :token, uniqueness: true

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
end
