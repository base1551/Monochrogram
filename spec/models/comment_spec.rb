require 'rails_helper'

RSpec.describe Comment, type: :model do
  it '内容がなければ無効であること' do
    comment = FactoryBot.create(:comment)
    comment.comment = nil
    expect(comment).to be_invalid
  end

  it '内容が240文字以下なら有効であること' do
    comment = FactoryBot.create(:comment)
    comment.comment = 'a' * 240
    expect(comment).to be_valid
  end

  it '内容が240文字以上なら無効であること' do
    comment = FactoryBot.create(:comment)
    comment.comment = 'a' * 241
    expect(comment).to be_invalid
  end

  it '新しい順で並んでいること' do
    post = FactoryBot.create(:post)
    most_recent_comment = FactoryBot.create(:comment, post: post, created_at: Time.zone.now)
    FactoryBot.create(:comment, post: post, created_at: 10.minutes.ago)
    FactoryBot.create(:comment, post: post, created_at: 3.years.ago)
    FactoryBot.create(:comment, post: post, created_at: 1.hours.ago)

    expect(most_recent_comment).to eq post.comments.first
  end
end
