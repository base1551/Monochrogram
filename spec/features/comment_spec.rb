# require 'rails_helper'

# RSpec.feature "Comments", type: :feature do
#   # ユーザー作成・投稿
#   user = FactoryBot.create(:user, name: 'alice')
#     visit root_path
#     fill_in 'user_email', with: user.email
#     fill_in 'user_password', with: user.password
#     click_button 'ログイン'

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


# end
