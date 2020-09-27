require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "#index" do

    context "ログインしたユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end
  
      it "200のレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do

      it "正常にレスポンスを返すこと" do
        get :index
        expect(response).to be_successful
      end
  
      it "200のレスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#show" do

    context "ログインしたユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end 

      it "200のレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do

      before do
        @post = FactoryBot.create(:post)
      end

      it "302のレスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        get :show, params: { id: @post.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
