require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  it 'ユーザーをフォロー/フォロー解除する', js: true do
    alice = FactoryBot.create(:user,
                              name: alice)
    bob = FactoryBot.create(:user,
                            name: bob)
    # ログインする
    visit new_user_session_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'ログイン'

    fill_in 'メールアドレス', with: 'alice'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'

    # フォローするユーザーページへ遷移
    visit user_path(bob)
    expect(page).to have_content 'bob'

    expect do
      click_button 'フォロー'
      expect(page).to have_content 'フォロー中'
      expect(find('#pills-folloew'))
    end
  end
end
