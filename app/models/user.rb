class User < ApplicationRecord
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_secure_password
  has_many :coin_relationships
  has_many :coins, through: :coin_relationships

  # Returns true if the current user is following the other user.
  def following?(coin_id)
    coins.include?(coin_id)
  end
end
