class User < ActiveRecord::Base
  has_many :posts, dependent: :delete_all

  has_many :relations, foreign_key: :follower_id, class_name: "Relation", dependent: :delete_all
  has_many :relations_inverse, foreign_key: :followed_id, class_name: "Relation"

  has_many :following, through: :relations, source: :following
  has_many :followers, through: :relations_inverse, source: :followed

  after_initialize :set_default_values

  validates :username, presence: true, length: { minimum: 5, maximum: 10 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.search(query)
    where("username like ?", "%#{query}%").order("created_at DESC")
  end

  def set_default_values
    self.followers_check_timestamp = Time.now unless persisted?
  end

  def not_seen_new_followers
    followers.where('relations.created_at > ?', followers_check_timestamp)
  end

  def is_following(user)
    following.include?(user)
  end

end
