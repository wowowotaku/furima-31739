require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    
    context '正常系' do
      it '全ての値が正常値であれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '異常系' do

      it 'メールアドレスが必須であること' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは@を含む必要があること' do
        @user.email = 'suzuki.gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが必須であること' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'aaaa1'
        @user.password_confirmation = 'aaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
        @user.password = 'aaaaa1'
        @user.password_confirmation = 'aaaaa2'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

        it 'ユーザー本名は、名字が必須であること' do
          @user.last_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end

      it 'ユーザー本名は、名前が必須であること' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'ユーザー本名のフリガナは、名字が必須であること' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'ユーザー本名のフリガナは、名前が必須であること' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '生年月日が必須であること' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Password Include both letters and numbers')
      end

      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password = 'aaaaa1'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                      "Password confirmation can't be blank")
      end

      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）の苗字が必須であること' do
        @user.last_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）の名前が必須であること' do
        @user.first_name = 'taichi'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'ユーザー本名のフリガナは、全角（カタカナ）の苗字入力が必須であること' do
        @user.last_name_kana = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'ユーザー本名のフリガナは、全角（カタカナ）の名前入力が必須であること' do
        @user.first_name_kana = 'ﾀｲﾁ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it 'パスワードは6文字以上であっても数字のみでは登録できない' do
        @user.password = '666666'
        @user.password_confirmation = '666666'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Password Include both letters and numbers")
      end

      it 'パスワードは6文字以上であっても英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Password Include both letters and numbers")
      end
    end
  end
end
