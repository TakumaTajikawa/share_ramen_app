class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :store, presence: true, length: { maximum: 20 }
  validates :prefecture, presence: true
  validates :genre, presence: true
  validates :ramen, presence: true, length: { maximum: 20 }
  validates :image, presence: true
end
