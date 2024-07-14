class User < ApplicationRecord
  validates :email, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :post
  has_many :subscribe
end
