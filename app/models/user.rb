class User < ApplicationRecord

  has_many :work_rates
  has_many :episode_rates
  has_many :works, through: :work_rates

  has_secure_password
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
end
