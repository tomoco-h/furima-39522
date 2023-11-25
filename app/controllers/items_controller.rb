class ItemsController < ApplicationController
  # before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all
  end

  def new
    @items = Item.new
  end
  
  def create
    @items = Items.new(items_params)

    if @items.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
  end

  private

  def items_params
    params.require(:items).permit(:name, :image).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   return if user_signed_in?

  #   redirect_to action: :index
#   end
end
