class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' #followクラスという存在しないクラスを参照することを防ぐ、Userモデルを参照する様に指示

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
