class User < ApplicationRecord
  attr_reader :password

  validates :password_digest, presence: true
  validates :activated, inclusion: { in: [true, false] }
  validates :email, :session_token, :activation_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  after_initialize :ensure_session_token, :ensure_activation_token

  has_many :notes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Note,
    dependent: :destroy

  def self.generate_unique_session_token
    token = SecureRandom::urlsafe_base64(16)

    while self.class.exists?(session_token: token)
      token = SecureRandom::urlsafe_base64(16)
    end

    token
  end

  def self.generate_unique_activation_token
    token = SecureRandom::urlsafe_base64(16)
    
    while self.class.exists?(activation_token: token)
      token = SecureRandom::urlsafe_base64(16)
    end

    token
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    if user && user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    password_digest = BCrypt::Password.new(self.password_digest)
    password_digest.is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_unique_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_unique_session_token
  end

  def ensure_activation_token
    self.activation_token = User.generate_unique_activation_token
  end

  def activate!
    self.update_attribute(:activated, true)
  end
end
