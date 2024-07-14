class User < ApplicationRecord
  validates :email, presence: true
  has_many :post
  has_many :subscribe

end
