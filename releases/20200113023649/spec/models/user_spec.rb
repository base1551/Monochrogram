require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tughts-furze",
    )
    expect(user).to be_valid
  end

  describe "存在性の検証" do
    it "名前がなければ無効な状態であること" do
      @user.name = nil
      expect(@user.valid?).to eq(false)
    end

    it "メールアドレスがなければ無効な状態であること" do
      @user.email = nil
      expect(@user.valid?).to eq(false)
    end

    it "パスワードがなければ無効な状態であること" do
      @user.password = nil
      expect(@user.valid?).to eq(false)
    end
  end

  describe "一意性の検証" do
    it "重複した名前は有効であること" do
      user = FactoryBot.create(:user, name: 'sample')
      duplicate_user = FactoryBot.build(:user, name: 'sample')
      expect(duplicate_user).to be_valid
    end

    it "重複したメールアドレスなら無効な状態であること" do
      user = FactoryBot.create(:user, email: 'sample@example.com')
      duplicate_user = FactoryBot.build(:user, email: 'sample@example.com')
      expect(duplicate_user.valid?).to eq(false)
    end

    it "メールアドレスは大文字小文字を区別せず扱うこと" do
      user = FactoryBot.create(:user, email: 'sample@example.com')
      duplicate_user  = FactoryBot.build(:user, email: 'SAMPLE@EXAMPLE.COM')
      expect(duplicate_user.valid?).to eq(false)
    end
  end

  describe "文字数の検証" do
    it "名前が50文字以内だと有効であること" do
      @user.name = 'a' * 50
      expect(@user).to be_valid
    end

    it "名前が50文字以上だと無効であること" do
      @user.name = 'a' * 51
      expect(@user).to be_invalid
    end

    it 'メールアドレスが255文字以内なら有効であること' do
      @user.email = 'a' * 243 + '@example.com'
      expect(@user).to be_valid
    end

    it 'メールアドレスが255文字以上なら無効であること' do
      @user.email = 'a' * 244 + '@example.com'
      expect(@user).to be_invalid
    end

    it 'パスワードが6文字以上なら有効であること' do
      @user.password = @user.password_confirmation = 'a' * 6
      expect(@user).to be_valid
    end

    it 'パスワードが7文字以下なら無効であること' do
      @user.password = @user.password_confirmation = 'a' * 5
      expect(@user).to be_invalid
    end
  end

  describe "その他" do
    it 'メールアドレスは全て小文字で保存されること' do
      @user.email = 'Foo@ExAMPle.CoM'
      @user.save!
      expect(@user.reload.email).to eq 'foo@example.com'
    end

    it "ユーザーを削除するとそのユーザーの投稿も削除されること" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)

      expect do
        user.destroy
      end.to change(Post, :count).by(-1)
    end
  end
end
