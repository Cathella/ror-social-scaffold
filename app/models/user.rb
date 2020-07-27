class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friend?(user)
    friends.include?(user)
  end

  def mutual_friends?(user)
    friend?(user) and user.friend?(self)
  end

  def confirm_friend(user)
    friends << user
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.friend.friend?(self) }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friend?(friendship.user) }.compact
  end
end
