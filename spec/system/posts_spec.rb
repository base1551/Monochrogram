# require 'rails_helper'

# RSpec.describe "投稿機能", type: :system do
#   before do
#     user_a = FactoryBot.create(:user, 'ユーザーA', email: 'a@example.com') # ユーザーAを作成しておく
#     user_b = FactoryBot.create(:user, 'ユーザーB', email: 'b@example.com') # ユーザーBを作成しておく

#     FactoryBot.create(:post, name: '投稿A', user: user_a) # 作成者がユーザーAである投稿を作成しておく
#     FactoryBot.create(:post, name: '投稿B', user: user_b) # 作成者がユーザーAである投稿を作成しておく
#   end

#   context 'ユーザーAがログインしているとき' do
#     before do
#       visit login_path  #ユーザーAでログイン
#       fill_in 'メールアドレス', with: 'a@example.com' #メールアドレスを入力する
#       fill_in 'パスワード', with: 'password' #パスワードを入力する
#       click_button 'ログイン' #ログインボタンを押す
#     end

#     it '全てのユーザーが作成したPostが表示される' do
#       expect(page).to have_content '投稿A', '投稿B' #作成済みの投稿の名称が画面上に表示されていることを確認
#     end
#   end
# end

