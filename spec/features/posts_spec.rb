require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  scenario "ユーザーはポストを作成できること" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      click_link "投稿を作成"
      fill_in "store", with: "大勝軒"
      select "東京都", from: "都道府県"
      select "つけ麺", from: "ジャンル"
      fill_in "ramen", with: "つけ麺大盛り"
      fill_in "impression", with: "美味しかったです"
      attach_file "image", Rails.root.join('share_ramen_app/public/uploads/post/image/451/test.jpg') 
      click_button "投稿"

      expect(page).to have_content "投稿しました"
      # expect(page).to have_content "Test Project"
      # expect(page).to have_content "User: #{user.name}"
    }.to change(user.posts, :count).by(1)
  end
end
