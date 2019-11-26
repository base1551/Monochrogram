require 'rails_helper'

RSpec.describe "UserLogins", type: :system do
  # 登録済みのユーザーを作成
  let(:user) { FactoryBot.create :user }

  # ログイン画面へ遷移
  before do
    visit new_user_session_path
  end

  context '有効な情報を送信したとき' do
    before do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ログインに成功すること' do
      expect(page).to have_content 'ログインしました。'
    end
  end

  context '無効な情報が送信されたとき' do
    before do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: 'user.password'
      click_button 'ログイン'
    end

    it 'ログインに失敗すること' do
      expect(page).to have_button 'ログイン'
    end
  end
end
