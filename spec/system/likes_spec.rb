require 'rails_helper'

RSpec.describe "Likes", type: :system do

  it "投稿にいいね/いいね解除する", js: true do
    # ユーザー・投稿を作成
    let(:post) { FactoryBot.create(:post) }
    post = FactoryBot.create(:post, user: 'foo')
    foo = FactoryBot.create.post
    # ログインする
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    # 投稿にいいねする
    visit root_path
    expect(find("love hide-text")).to have_content ''

    expect do
      click_on "love hide-text"
      expect(find("love hide-text")).to have_content 'が「いいね！」しました'
    end.to change(post.likes, :count).by(1)
    # 投稿のいいねを解除する
  end
end



