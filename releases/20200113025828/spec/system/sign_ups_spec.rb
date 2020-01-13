require 'rails_helper'

RSpec.describe "SignUps", type: :system do
  before do
    visit new_user_registration_path
  end

  # 有効なユーザーの場合
  describe '有効なユーザーの場合' do
    before do
      fill_in 'メールアドレス', with: 'foo@example.com'
      fill_in 'フルネーム', with: 'foo@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワードの確認', with: 'password'
      click_button '新規登録'
    end
    it '成功メッセージが表示されること' do
      expect(page).to have_content 'アカウント登録が完了しました。'
    end
  end


  describe '無効なユーザーの場合' do
    before do
      fill_in 'メールアドレス', with: ''
      fill_in 'フルネーム', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワードの確認', with: ''
      click_button '新規登録'
    end

    it '成功メッセージが表示されないこと' do
      expect(page).to_not have_content 'アカウント登録が完了しました。'
    end
    it '新規登録画面が表示されること' do
      expect(page).to have_button '新規登録'
    end
  end
end
