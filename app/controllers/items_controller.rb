class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :show, :update]
  before_action :seller, only: [:edit, :update]
  before_action :sold_out, only:[:edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(items_params)

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(items_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])

    unless current_user && current_user.id == item.user_id
      redirect_to root_path, alert: "編集権限がありません"
      return
    end

    item.destroy
    redirect_to root_path
  end

  private

  def items_params
    params.require(:item).permit(:name, :image, :explanation, :category_id, :condition_id, :charge_id, :prefecture_id, :shipping_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def seller
    unless current_user && current_user.id == @item.user_id
      redirect_to root_path, alert: "編集権限がありません"
      return
    end
  end

  def sold_out
    if @item.order.present?
      redirect_to root_path
    end
  end
end
