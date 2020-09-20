class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :introduction, presence: false, length: { maximum: 200 } 
  mount_uploader :image, ImageUploader
  

  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  def posts
    return Post.where(user_id: self.id)
  end
end