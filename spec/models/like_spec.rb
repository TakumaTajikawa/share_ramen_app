require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  it "一人のユーザーが同じ投稿に複数の食べたい！は押せないこと" do
    user.likes.create(post_id: post.id)
    new_like = user.likes.create(post_id: post.id)
    expect(new_like).to be_invalid
  end

  it "異なるユーザーは同じ投稿に食べたい！を押せること" do
    user.likes.create(post_id: post.id)
    new_like = other_user.likes.create(post_id: post.id)
    expect(new_like).to be_valid
  end
end
