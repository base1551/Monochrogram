require 'rails_helper'

RSpec.describe "Likes", type: :system do

  it "投稿にいいね/いいね解除する", js: true do
   # ユーザー・投稿を作成
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, :with_photos, photos_count: 1, user: user)

    # ログインする
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    # 投稿にいいねする
    visit root_path
    expect do
      page.all(:link,"いいね")[0].click
      expect(page).to have_content 'が「いいね！」しました'
    end.to change(post.likes, :count).by(1)
    # 投稿のいいねを解除する
  end
end



