require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '正常系' do
      it '必要な情報を適切に入力すると、商品の出品ができること' do
        expect(@item).to be_valid
      end
    end

    context '異常系' do
      it '商品画像を1つつけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.explain = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", 'Category is not a number')
      end

      it '商品の状態についての情報が必須であること' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank", 'Status is not a number')
      end

      it '配送料の負担についての情報が必須であること' do
        @item.shippingfee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingfee can't be blank", 'Shippingfee is not a number')
      end

      it '発送元の地域についての情報が必須であること' do
        @item.from_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("From can't be blank", 'From is not a number')
      end

      it '発送までの日数についての情報が必須であること' do
        @item.day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank", 'Day is not a number')
      end

      it '価格についての情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格の範囲が¥300以上であること' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格の範囲が¥9,999,999以下であること' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '８００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
