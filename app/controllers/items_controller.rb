class ItemsController < ApplicationController
  # before_action :move_to_index, except: [:index, :show]

  def index
  end

  def new
  end
  
  def create
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
