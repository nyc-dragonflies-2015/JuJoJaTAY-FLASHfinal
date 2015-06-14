class User < ActiveRecord::Base
  include BCrypt
  has_many :rounds
  has_many :guesses, through: :rounds
  has_many :decks, through: :rounds

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def authenticate(plaintext_password)
    self.password == plaintext_password
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
