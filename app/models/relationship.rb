# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User' # followerメソッドを定義
  belongs_to :followed, class_name: 'User' # followedメソッドを定義
  validates :follower_id,  presence: true
  validates :followed_id,  presence: true
end
