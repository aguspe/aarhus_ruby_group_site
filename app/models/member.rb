class Member < ApplicationRecord
  has_many :rsvps, dependent: :destroy
  has_many :events, through: :rsvps

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  def generate_auth_token!
    update!(
      auth_token: SecureRandom.urlsafe_base64(32),
      auth_token_expires_at: 30.minutes.from_now
    )
    auth_token
  end

  def clear_auth_token!
    update!(auth_token: nil, auth_token_expires_at: nil)
  end

  def auth_token_valid?
    auth_token.present? && auth_token_expires_at&.future?
  end
end
