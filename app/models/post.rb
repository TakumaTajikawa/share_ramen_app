class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :store, presence: true, length: { maximum: 20 }
  validates :prefecture, presence: true
  validates :genre, presence: true
  validates :ramen, presence: true, length: { maximum: 20 }
  validates :image, presence: true
end
