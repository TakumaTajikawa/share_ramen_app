require 'rails_helper'

RSpec.describe Post, type: :model do

  describe Post do
    it "有効なファクトリを持つこと" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  
  context "バリデーション" do
    
    it "店名、都道府県、ジャンル、品名、感想、画像があればポストが有効な状態であること" do
      post = FactoryBot.create(:post)
      expect(post).to be_valid
    end
  
    it "店名がなければ無効な状態であること" do
      post = FactoryBot.build(:post, store: nil)
      post.valid?
      expect(post.errors[:store]).to include("を入力してください")
    end

    it "店名が16文字以内であれば有効であること" do
      post = FactoryBot.build(:post, store: "a" * 16)
      expect(post).to be_valid
    end

    it "店名が17文字以上だと無効であること" do
      post = FactoryBot.build(:post, store: "a" * 17)
      post.valid?
      expect(post.errors[:store]).to include("は16文字以内で入力してください")
    end

    it "都道府県がなければ無効な状態であること" do
      post = FactoryBot.build(:post, prefecture: nil)
      post.valid?
      expect(post.errors[:prefecture]).to include("を選択してください")
    end
  
    it "ジャンルがなければ無効な状態であること" do
      post = FactoryBot.build(:post, genre: nil)
      post.valid?
      expect(post.errors[:genre]).to include("を選択してください")
    end

    it "品名がなければ無効な状態であること" do
      post = FactoryBot.build(:post, ramen: nil)
      post.valid?
      expect(post.errors[:ramen]).to include("を入力してください")
    end

    it "品名が16文字以内であれば有効であること" do
      post = FactoryBot.build(:post, ramen: "a" * 16)
      expect(post).to be_valid
    end

    it "品名が17文字以上だと無効であること" do
      post = FactoryBot.build(:post, ramen: "a" * 17)
      post.valid?
      expect(post.errors[:ramen]).to include("は16文字以内で入力してください")
    end
  
    it "感想がなければ無効な状態であること" do
      post = FactoryBot.build(:post, impression: nil)
      post.valid?
      expect(post.errors[:impression]).to include("を入力してください")
    end

    it "感想が110文字以内であれば有効であること" do
      post = FactoryBot.build(:post, impression: "a" * 110)
      expect(post).to be_valid
    end

    it "感想が111文字以上だと無効であること" do
      post = FactoryBot.build(:post, impression: "a" * 111)
      post.valid?
      expect(post.errors[:impression]).to include("は110文字以内で入力してください")
    end

    it "画像がなければ無効な状態であること" do
      post = FactoryBot.build(:post, image: nil)
      post.valid?
      expect(post.errors[:image]).to include("をアップロードしてください")
    end
  end
end
