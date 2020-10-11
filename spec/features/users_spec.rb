require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "未登録ユーザーがアカウント登録できること" do
    visit root_path

    expect {
      click_link "新規登録"
      fill_in "ユーザー名", with: "山田太郎"
      fill_in "Eメール", with: "aaaaa@example.com"
      fill_in "パスワード", with: "yamada"
      fill_in "パスワード（確認用）", with: "yamada"
      click_button "アカウント登録"
    }.to change(User, :count).by(1)
  end
end
