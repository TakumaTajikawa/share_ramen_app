require 'rails_helper'

RSpec.describe LikesController, type: :controller do 

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @like = @user.likes.create!(post: @post)
  end

  describe "#create" do

    it "JSON 形式でレスポンスを返すこと" do
      post :create, format: :json,
      params: { post_id: @post.id, id: @like.id }
      expect(response.content_type).to eq "application/json; charset=utf-8"
    end
  end

  describe "destroy" do

    it "JSON 形式でレスポンスを返すこと" do
      delete :destroy, format: :json,
      params: { post_id: @post.id, id: @like.id }
      expect(response.content_type).to eq "application/json; charset=utf-8"
    end
  end
end