require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "#create" do

    context "ログインしているユーザーとして" do

      let(:user) { FactoryBot.create(:user) }
      let(:post) { FactoryBot.create(:post) }

      it "コメントができること" do
        sign_in user
        expect { user.comment.create!(content: "美味しそう", post: post) }.to change { Comment.count }.by(1)
      end
    end
  end

  describe "#destroy" do

    context "コメント投稿者のログインユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @comment = FactoryBot.create(:comment, post: @post, user: @user)
      end

      it "自分が投稿したコメントを削除できること" do
        sign_in @user
        expect { @comment.destroy }.to change { Comment.count }.by(-1)
      end
    end

    context "ポスト投稿者がログインユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @comment = FactoryBot.create(:comment, post: @post, user: @other_user)
      end

      it "自分のポストに投稿された他のユーザーのコメントを削除できること" do
        sign_in @user
        expect { @comment.destroy }.to change { Comment.count }.by(-1)
      end
    end
  end
end