class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  attachment :profile_image # ここを追加（_idは含めない）
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user, dependent: :destroy
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
end
