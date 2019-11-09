class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :photos

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end

  def like?(user)
    like_users.inculde?(user)
  end

  def to_param
    url_token
  end

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    like_users.include?(user)
  end

  private

    def generate_url_token
      self.url_token = SecureRandom.urlsafe_base64
    end
end
