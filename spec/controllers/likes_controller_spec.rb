require 'rails_helper'

RSpec.describe LikesController, type: :controller do 

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @like = @user.likes.create!(post: @post)
  end

  describe "#create" do

    it "JSON 形式でレスポンスを返すこと" do
      post :create, format: :json, params: { post_id: @post.id, id: @like.id }
      expect(response.content_type).to eq "application/json; charset=utf-8"
    end

    it "食べたい！を追加できること" do
      sign_in @user
      user2 = FactoryBot.create(:user)
      post2 = FactoryBot.create(:post, user: user2)
      expect { @user.likes.create!(post: post2) }.to change { Like.count }.by(1)
    end
  end

  describe "destroy" do

    it "JSON 形式でレスポンスを返すこと" do
      delete :destroy, format: :json,
      params: { post_id: @post.id, id: @like.id }
      expect(response.content_type).to eq "application/json; charset=utf-8"
    end

    it "食べたい！を削除できること" do
      sign_in @user
      expect { @like.destroy }.to change { Like.count }.by(-1)
    end
  end
end