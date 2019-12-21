class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow #followingモデルは存在しないのでthroughで中間モデルである事を補足。source: :followでrelationshipsテーブルのfollow_idを参考にアクセスすることを補足
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id' #has_many :relationshipsの逆と言う意味
  has_many :followrs, through: :reverse_of_relationships, source: :user

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

  # フォローユーザーが自分自身でなければ
  def follow(other_user) #self = 実行したUserのインスタンス
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # アンフォロー
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship #後置if文
  end

  # 既にフォロー済みのユーザーに含まれていないか確認
  def following?(other_user)
    self.followings.include?(other_user)
  end
end
