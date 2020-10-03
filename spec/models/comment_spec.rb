require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment) }

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  # 文章、ポストid、ユーザーidがあれば有効な状態であること
  it 'user_id,post_id,contentがあればコメントが有効であること' do
    expect(comment).to be_valid
  end

  it 'post_idがなければ無効であること' do
    comment.post_id = nil
    expect(comment).to be_invalid
  end

  it 'contentがなければ無効であること' do
    comment.content = nil
    expect(comment).to be_invalid
  end

  it 'user_idがなければ無効であること' do
    comment.user_id = nil
    expect(comment).to be_invalid
  end

  
  it 'コメントが250文字以内なら有効であること' do
    comment.content = 'a' * 250
    expect(comment).to be_valid
  end

  it 'コメントが251文字以上なら無効であること' do
    comment.content = 'a' * 251
    expect(comment).to be_invalid
  end
end