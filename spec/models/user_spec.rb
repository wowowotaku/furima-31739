require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do 
      @user = FactoryBot.build(:user)
    end

    it "メールアドレスが必須であること" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "メールアドレスが一意性であること" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "メールアドレスは@を含む必要があること" do
      expect(@user.email).to include ("@")
    end

    it "パスワードが必須であること" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "パスワードは、6文字以上での入力が必須であること" do
      @user.password = "aaaaa1"
      @user.password_confirmation = "aaaaa1"
      expect(@user).to be_valid
    end

    it "パスワードは、5文字以下であれば登録できない" do
      @user.password = "aaaa1"
      @user.password_confirmation = "aaaa1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードとパスワード（確認用）、値の一致が必須であること" do
      @user.password = "aaaaa1"
      @user.password_confirmation = "aaaaa2"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "ユーザー本名は、名字が必須であること" do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "ユーザー本名は、名前が必須であること" do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "ユーザー本名のフリガナは、名字が必須であること" do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it "ユーザー本名のフリガナは、名前が必須であること" do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it "生年月日が必須であること" do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it "パスワードは、半角英数字混合での入力が必須であること" do  
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Password Include both letters and numbers")
    end

    it "パスワードは、確認用を含めて2回入力すること" do
      user = User.new(nickname: "suzuki", email: "suzuki@gmail.com", password: "aaaaa1", password_confirmation: "", first_name: "太一", last_name: "鈴木", last_name_kana: "スズキ", first_name_kana: "タイチ", birthday: "1990-05-15")
      user.valid?
    end

    it "ユーザー本名は、全角（漢字・ひらがな・カタカナ）の苗字が必須であること" do
      user = User.new(nickname: "suzuki", email: "suzuki@gmail.com", password: "aaaaa1", password_confirmation: "aaaaa1", first_name: "太一", last_name: "suzuki", last_name_kana: "スズキ", first_name_kana: "タイチ", birthday: "1990-05-15")
      user.valid?
      expect(user.errors.full_messages).to include("Last name Last name Full-width characters")
    end

    it "ユーザー本名は、全角（漢字・ひらがな・カタカナ）の名前が必須であること" do
      user = User.new(nickname: "suzuki", email: "suzuki@gmail.com", password: "aaaaa1", password_confirmation: "aaaaa1", first_name: "taichi", last_name: "鈴木", last_name_kana: "スズキ", first_name_kana: "タイチ", birthday: "1990-05-15")
      user.valid?
      expect(user.errors.full_messages).to include("First name First name Full-width characters")
    end

    it "ユーザー本名のフリガナは、全角（カタカナ）の苗字入力が必須であること" do
      user = User.new(nickname: "suzuki", email: "suzuki@gmail.com", password: "aaaaa1", password_confirmation: "aaaaa1", first_name: "太一", last_name: "鈴木", last_name_kana: "ｽｽﾞｷ", first_name_kana: "タイチ", birthday: "1990-05-15")
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana Last name kana Full-width katakana characters")
    end

    it "ユーザー本名のフリガナは、全角（カタカナ）の名前入力が必須であること" do
      user = User.new(nickname: "suzuki", email: "suzuki@gmail.com", password: "aaaaa1", password_confirmation: "aaaaa1", first_name: "太一", last_name: "鈴木", last_name_kana: "スズキ", first_name_kana: "ﾀｲﾁ", birthday: "1990-05-15")
      user.valid?
      expect(user.errors.full_messages).to include("First name kana First name kana Full-width katakana characters")
    end
  end

  describe "ログイン機能" do

    it "ログアウト状態では、ヘッダーにログインボタンが表示されること" do
      
      expect(page). to have_content('ログイン')
    end

    it "ログアウト状態では、ヘッダーに新規登録ボタンが表示されること" do
      
      expect(page). to have_content('新規登録')
    end

    it "ログイン状態では、ヘッダーにユーザーのニックネームが表示されること" do
      @user = FactoryBot.build(:user)
      expect(page). to have_content('#{current_user.nickname}')
    end

    it "ログイン状態では、ヘッダーにユーザーのログアウトボタンが表示されること" do
      @user = FactoryBot.build(:user)
      expect(page). to have_content('ログアウト')
    end

    it "ヘッダーのログインボタンをクリックすることで、ページに遷移できること" do

      click_on('ログイン')
      expect(current_path). to eq user_session_path
    end

    it "ヘッダーの新規登録ボタンをクリックすることで、ページに遷移できること" do

      click_on('新規登録')
      expect(currrent_path). to eq new_user_registration_path 
    end
    
    it "ヘッダーのログアウトボタンをクリックすることで、ログアウトができること" do
      
      click_on('ログアウト')
      expect(current_path). to eq root_path
    end
  end
end
