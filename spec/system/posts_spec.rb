# require 'rails_helper'

# RSpec.describe "投稿機能", type: :system do
#   it '新規投稿/投稿削除' do
#     user = FactoryBot.create(:user, email: 'foo@example.com')

#     visit root_path
#     fill_in 'user_email', with: 'foo@example.com'
#     fill_in 'user_password', with: user.password
#     click_button 'ログイン'

#     # 新規投稿
#     visit root_path
#     click_on '投稿'
#     expect(current_path).to eq new_post_path

#     attach_file 'post[photos_attributes][0][image]', "#{Rails.root}/spec/fixtures/test.jpg", make_visible: true
#     fill_in 'post_caption', with: 'I love it.'
#     expect do
#       click_button '投稿'
#     end.to change(Post, :count).by(1)

#     expect(current_path).to eq root_path
#     expect(page).to have_content('投稿が保存されました')

#     # 投稿削除
#     expect do
#       find('.delete-post-icon').click
#       expect(page).to have_content('投稿が削除されました')
#     end.to change(Post, :count).by(-1)
#   end
# end

