# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password is too short" }
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  after_initialize :ensure_session_token
  has_many(
    :goals,
    class_name: "Goal",
    foreign_key: :goal_setter_id,
    primary_key: :id
  )
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
end
