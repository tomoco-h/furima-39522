require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品の出品登録' do
      context '出品登録ができるとき' do
        it '全ての入力事項が、存在すれば登録できる' do
          expect(@item).to be_valid
        end
        it 'カテゴリーが「---」以外であれば登録できる' do
          @item.category_id = 2
          expect(@item).to be_valid
        end
        it '商品の状態が「---」以外であれば登録できる' do
          @item.condition_id = 2
          expect(@item).to be_valid
        end
        it '配送料の負担が「---」以外であれば登録できる' do
          @item.charge_id = 2
          expect(@item).to be_valid
        end
        it '発送元の地域が「---」以外であれば登録できる' do
          @item.prefecture_id = 2
          expect(@item).to be_valid
        end
        it '発送までの日数が「---」以外であれば登録できる' do
          @item.shipping_id = 2
          expect(@item).to be_valid
        end
        it '価格が半角数字でかつ300円〜9,999,999円であれば登録できる' do
          @item.price = 300
          expect(@item).to be_valid
        end
      end
  
      context '出品ができないとき' do
        it '１枚画像がないと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it '商品名が空欄だと出品できない' do
          @item.name = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it '商品名が41字以上だと出品できない' do
          item = FactoryBot.build(:item, name: 'a' * 41)
          item.valid?
          expect(item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
        end
        it '商品の説明が空欄だと出品できない' do
          @item.explanation = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Explanation can't be blank")
        end
        it '商品の説明が1001字以上だと出品できない' do
          item = FactoryBot.build(:item, explanation: 'a' * 1001)
          item.valid?
          expect(item.errors.full_messages).to include("Explanation is too long (maximum is 1000 characters)")
        end
        it 'カテゴリーの情報が「---」だと出品できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category must be other than 1")
        end
        it 'カテゴリーの情報が空欄だと出品できない' do
          @item.category_id = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Category is not a number")
        end
        it '商品の状態の情報が「---」だと出品できない' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition must be other than 1")
        end
        it '商品の状態の情報が空欄だと出品できない' do
          @item.condition_id = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition is not a number")
        end
        it '配送料の負担の情報が「---」だと出品できない' do
          @item.charge_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Charge must be other than 1")
        end
        it '配送料の負担の情報が空欄だと出品できない' do
          @item.charge_id = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Charge is not a number")
        end
        it '発送元の地域の情報が「---」だと出品できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
        end
        it '発送元の地域の情報が空欄だと出品できない' do
          @item.prefecture_id = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture is not a number")
        end
        it '発送までの日数の情報が「---」だと出品できない' do
          @item.shipping_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping must be other than 1")
        end
        it '発送までの日数の情報が空欄だと出品できない' do
          @item.shipping_id = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping is not a number")
        end
        it '価格が空欄だと出品できない' do
          @item.price = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number')
        end
        it '価格の範囲が、300円未満だと出品できない' do
          @item.price = 100
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
        end
        it '価格の範囲が、9,999,999円を超えると出品できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
        end
      end
    end
  end
end
