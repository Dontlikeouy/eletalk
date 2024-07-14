class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
    validates :image, presence: true

  has_one_attached :image
  
  has_many :favorite
  has_many :comment

  belongs_to :user
end
