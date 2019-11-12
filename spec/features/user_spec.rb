require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'サインアップ処理' do
    visit root_path
    expect(page).to have_no_css('投稿')

    visit new_user_registration_path
    fill_in 'user_email', with: 'foo@example.com'
    fill_in 'user_name', with: 'テストユーザー'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button '登録する'
    expect(page).to have_content('アカウント登録が完了しました。')
  end

  scenario 'ログイン処理' do
    visit root_path
    expect(current_path).to eq new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログイン'
    expect(page).to have_content('ログインしました。')
  end
end
