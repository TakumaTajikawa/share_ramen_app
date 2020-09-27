require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#index" do

    context "ログインしているユーザーとして" do

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

      it "302のレスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#show" do

    context "ログインユーザーが自分のユーザー詳細ページにアクセスするとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_successful
      end 

      it "200のレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "ログインユーザーが他人のユーザー詳細ページにアクセスするとして" do

      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @other_user.id }
        expect(response).to be_successful
      end 

      it "200のレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @other_user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーがユーザー詳細ページにアクセスするとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "302のレスポンスを返すこと" do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#edit" do

    context "ユーザー本人がログイン状態として" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :edit, params: { id: @user.id }
        expect(response).to be_successful
      end 

      it "200のレスポンスを返すこと" do
        sign_in @user
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "ユーザー本人ではないログインユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "302のレスポンスを返すこと" do
        sign_in @user
        get :edit, params: { id: @other_user.id }
        expect(response).to have_http_status "302"
      end

      it "投稿一覧ページにリダイレクトすること" do
        sign_in @user
        get :edit, params: { id: @other_user.id }
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていないユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "302のレスポンスを返すこと" do
        get :edit, params: { id: @user.id}
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end




end