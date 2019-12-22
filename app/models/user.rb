class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :active_relationships,   class_name:   "Relationship",
                                    foreign_key:  "follower_id", # デフォルトではuser_idに紐づけられるので指定
                                    dependent:    :destroy
  has_many :passive_relationships,  class_name:   "Relationship",
                                    foreign_key:  "followed_id", # デフォルトではuser_idに紐づけられるので指定
                                    dependent:    :destroy
  has_many :following,
            through: :active_relationships, # active_relationshipsメソッドを呼び出し
            source: :followed               # 各要素に対してfollowedメソッドを実行
  has_many :followers,
            through: :passive_relationships, # active_relationshipsメソッドを呼び出し
            source: :follower                # 各要素に対してfollowedメソッドを実行

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }
  validates :password, length: { minimum: 6 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # フォロー機能のメソッド

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # アンフォロー
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 既にフォロー済みのユーザーに含まれていないか確認
  def following?(other_user)
    following.include?(other_user)
  end
end
