require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  scenario "ユーザーはログインでき、ポストを作成できること" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {sr_.
      click_link "投稿を作成"
      fill_in "store", with: "大勝軒"
      select "東京都", from: "都道府県"
      select "つけ麺", from: "ジャンル"
      fill_in "ramen", with: "つけ麺大盛り"
      fill_in "impression", with: "美味しかったです"
      attach_file "post[image]", "#{Rails.root}/public/uploads/test_image/test.jpg"
      click_button "投稿"
    }.to change(user.posts, :count).by(1)
  end
end
