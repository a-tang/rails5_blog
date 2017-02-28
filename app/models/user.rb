class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}"
  end

end
