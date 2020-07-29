class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # all friendships user created
  has_many :friendships, dependent: :destroy
  # all friendships created by other users
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # all accepted friendships user created
  has_many :accepted_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :accepted_inverse_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'friend_id'

  # all friendships user created but has not been accepted
  has_many :pending_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: 'user_id'
  # array of users that request was sent to but have not accepted
  has_many :pending_friends, through: :pending_friendships, source: :friend, foreign_key: 'friend_id'

  # all friendships self received but has not accepted
  has_many :received_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: 'friend_id'
  # array of users who sent a request that self hasn't accepted
  has_many :friend_requests, through: :received_friendships, source: :user, foreign_key: 'user_id'

  # friends
  # has_many :friends_accepted, through: :accepted_inverse_friendships, source: :user, foreign_key: 'user_id'
  # has_many :friends_initiated, through: :accepted_friendships
  has_many :friends, through: :friendships

  def friend?(user)
    friends.include?(user)
  end

  def mutual_friends?(user)
    friend?(user) and user.friend?(self)
  end

  def all_friends
    (accepted_friendships + accepted_inverse_friendships).compact
  end

  def confirm_friend(user)
    friendship = friendships.build(friend: user, confirmed: true)
    friendship.save
  end

  def request_accepted(user)
    friendship = friendships.where(friend: user)[0]
    friendship.confirmed = true
    friendship.save
  end
end
