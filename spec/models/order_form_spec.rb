require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe OrderForm, type: :model do
  describe "商品購入記録の保存" do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item, user: @user)
      @orderform = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    context "内容に問題がない場合" do
      it "すべての値が正しく入力されていれば購入できること" do
        expect(@orderform).to be_valid
      end
      it "建物名が空でも購入できること" do
        @orderform.building_name = ""
        expect(@orderform).to be_valid
      end
    end

    context "内容に不備がある場合" do
      it "郵便番号が空では購入できない" do
        @orderform.post_code = ""
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Post code can't be blank")
      end
      it "郵便番号が「3桁ハイフン4桁」の半角文字列でなければ購入できない" do
        @orderform.post_code = "123123４"
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "都道府県に「---」が選択されている場合は購入できない" do
        @orderform.prefecture_id = "1"
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "市区町村が空では購入できない" do
        @orderform.municipalities = ""
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Municipalities can't be blank")
      end
      it "番地が空では購入できない" do
        @orderform.street_address = ""
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Street address can't be blank")
      end
      it "電話番号が空では購入できない" do
        @orderform.phone = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Phone can't be blank")
      end
      it "電話番号が9桁以下だと購入できない" do
        @orderform.phone = "090123456"
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Phone is invalid. Include hyphen(-)")
      end
      it "電話番号が12桁以上だと購入できない" do
        @orderform.phone = "090123456789"
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Phone is invalid. Include hyphen(-)")
      end
      it "電話番号が半角数値でなければ購入できない" do
        @orderform.phone = "０９０１２３４１２３４"
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Phone is invalid. Include hyphen(-)")
      end
      it 'user_idが紐づいていなければ購入できない' do
        @orderform.user_id = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("User can't be blank")
      end
      it 'product_idが紐づいていなければ購入できない' do
        @orderform.item_id = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では購入できない' do
        @orderform.token = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
