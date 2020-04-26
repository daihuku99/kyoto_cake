class Customers::CartItemsController < ApplicationController

  def create
    cart_item = current_end_user.cart_items.new(cart_item_params)
    unless current_end_user.add_item?(cart_item_params[:item_id].to_i)
      cart_item.save
    end
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def empty
    current_end_user.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id)
  end
end
