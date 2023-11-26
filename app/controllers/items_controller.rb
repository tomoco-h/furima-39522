class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @item = Item.all
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

  private

  def items_params
    params.require(:item).permit(:name, :image, :explanation, :category_id, :condition_id, :charge_id, :prefecture_id, :shipping_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?

    redirect_to new_user_session_path
  end
end
