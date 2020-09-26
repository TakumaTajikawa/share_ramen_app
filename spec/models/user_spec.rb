require 'rails_helper'

RSpec.describe User, type: :model do

  describe User do
    it "有効なファクトリを持つこと" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  context "バリデーション" do

    it "名前、メール、パスワードがあれば有効な状態であること" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end
  
    it "名前がなければ無効な状態であること" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
  
    it "名前が15文字以内であれば有効であること" do
      user = FactoryBot.build(:user, name: "a" * 15)
      expect(user).to be_valid
    end
  
    it "名前が16文字以上だと無効であること" do
      user = FactoryBot.build(:user, name: "a" * 16)
      user.valid?
      expect(user.errors[:name]).to include("は15文字以内で入力してください")
    end
  
    it "メールアドレスがなければ無効な状態であること" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "メールアドレスが50文字以内であれば有効であること" do
      user = FactoryBot.build(:user, email: "#{"a" * 38}@example.com")
      expect(user).to be_valid
    end
  
    it "メールアドレスが51文字以上だと無効であること" do
      user = FactoryBot.build(:user, email: "#{"a" * 39}@example.com")
      user.valid?
      expect(user.errors[:email]).to include("は50文字以内で入力してください")
    end
    
    it "重複したメールアドレスなら無効な状態であること" do
      FactoryBot.create(:user, email: "yamada@example.com")
      user = FactoryBot.build(:user, email: "yamada@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    it "パスワードがなければ無効な状態であること" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードが6文字以上であれば有効であること" do
      user = FactoryBot.build(:user, password: "a" * 6)
      expect(user).to be_valid
    end

    it "パスワードが5文字以内だと無効であること" do
      user = FactoryBot.build(:user, password: "a" * 5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end

end
