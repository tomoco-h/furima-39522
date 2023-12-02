class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_out
  before_action :seller

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @orderform = OrderForm.new
  end

  def create
    @orderform = OrderForm.new(order_params)
    if @orderform.valid?
      pay_item
      @orderform.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end  

  private
  def order_params
    params.require(:order_form).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :phone).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy' )
  end

  def seller
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def sold_out
    @item = Item.find(params[:item_id])
    if @item.order.present?
      redirect_to root_path
    end
  end
end