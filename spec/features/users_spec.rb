require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  scenario "未登録ユーザーがアカウント登録できること" do

    expect {
      click_link "新規登録"
      fill_in "ユーザー名", with: "山田太郎"
      fill_in "Eメール", with: "aaaaa@example.com"
      fill_in "パスワード", with: "yamada"
      fill_in "パスワード（確認用）", with: "yamada"
      click_button "アカウント登録"

      expect(page).to have_content "アカウント登録しました"

    }.to change(users_url, :count).by(1)
  end
end
