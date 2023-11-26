class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])

    unless current_user && current_user.id == @item.user_id
      redirect_to root_path, alert: "編集権限がありません"
    end

  end

  def update
    @item = Item.find(params[:id])

    if @item.update(items_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end

    unless current_user && current_user.id == @item.user_id
      redirect_to root_path, alert: "編集権限がありません"
      return
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :image, :explanation, :category_id, :condition_id, :charge_id, :prefecture_id, :shipping_id, :price).merge(user_id: current_user.id)
  end
end
