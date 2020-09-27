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

  describe "#update" do

    context "ユーザー本人がログイン状態として" do
      
      before do
        @user = FactoryBot.create(:user)
      end

      it "プロフィールを更新できること" do
        user_params = FactoryBot.attributes_for(:user, introduction: "宜しくお願いします")
        sign_in @user
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.introduction).to eq "宜しくお願いします"
      end 
    end

    context "ユーザー本人ではないログインユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "プロフィールを更新できないこと" do
        user_params = FactoryBot.attributes_for(:user, introduction: "宜しくお願いします")
        sign_in @other_user
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.introduction).to eq nil
      end

      it "投稿一覧ページへリダイレクトすること" do
        user_params = FactoryBot.attributes_for(:user)
        sign_in @other_user
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to root_path
      end 
    end

    context "ログインしていないユーザーとして" do
      
      before do
        @user = FactoryBot.create(:user)
      end

      it "302のレスポンスを返すこと" do
        user_params = FactoryBot.attributes_for(:user)
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        user_params = FactoryBot.attributes_for(:user)
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to new_user_session_path
      end 
    end
  end

  describe "#destroy" do

    context "ユーザー本人がログイン状態として" do
      
      before do
        @user = FactoryBot.create(:user)
      end

      it "アカウントを削除できること" do
        sign_in @user
        expect { delete :destroy, params: { id: @user.id } }.to change { User.count }.by(-1)
      end 
    end

    context "ユーザー本人ではないログインユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "他人のアカウントを削除できないこと" do
        sign_in @other_user
        expect { delete :destroy, params: { id: @user.id } }.to_not change(User, :count)
      end

      it "投稿一覧ページへリダイレクトすること" do
        sign_in @other_user
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to root_path
      end 
    end

    context "ログインしていないユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "302のレスポンスを返すこと" do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end

      it "他人のアカウントを削除できないこと" do
        expect { delete :destroy, params: { id: @user.id } }.to_not change(User, :count)
      end 
    end
  end






end