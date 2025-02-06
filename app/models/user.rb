class User < ApplicationRecord
  require 'bcrypt'
  
  has_secure_password
  
  has_many :notes
  has_many :tasks
  has_many :wiki_pages
  has_many :chat_messages
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, on: :create
  
  # Add password digest handling
  def password
    @password ||= BCrypt::Password.new(password_digest) if password_digest
  end
  
  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password) if new_password.present?
  end
  
  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end
  
  def admin?
    admin
  end
end 