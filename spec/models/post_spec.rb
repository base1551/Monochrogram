require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }
  it '有効なファクトリを持つこと' do
    expect(post).to be_valid
  end

  describe '有効性の検証' do
    it 'ユーザーがなければ無効な状態であること' do
      post.user = nil
      expect(post).to be_invalid
    end

    it '画像がなければ無効な状態であること' do
      # post.photos = nil
      # expect(post).to be_invalid
    end
  end

  describe 'メソッド' do
    it '投稿をいいねできること' do
      alice = FactoryBot.create(:user)
      bob = FactoryBot.create(:user, :with_posts, posts_count: 1)
      expect(bob.posts.first.like?(alice)).to eq false
      bob.posts.first.like(alice)
      expect(bob.posts.first.like?(alice)).to eq true
      bob.posts.last.unlike(alice)
      expect(bob.posts.first.like?(alice)).to eq false
    end
  end

  describe 'その他' do
    it '新しい順に並んでいること' do
      most_recent_post = FactoryBot.create(:post, created_at: Time.zone.now)
      FactoryBot.create(:post, created_at: 10.minutes.ago)
      FactoryBot.create(:post, created_at: 5.years.ago)
      FactoryBot.create(:post, created_at: 2.hours.ago)

      expect(most_recent_post).to eq Post.first
    end

    it '投稿を削除すると、関連するコメントも削除されること' do
      post = FactoryBot.create(:post, :with_comments, comments_count: 1)

      expect do
        post.destroy
      end.to change(Comment, :count).by(-1)
    end

    it '投稿を削除すると、関連するいいねも削除されること' do
      post = FactoryBot.create(:post, :with_likes, likes_count: 1)

      expect do
        post.destroy
      end.to change(Like, :count).by(-1)
    end
  end
end
