class Admins::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.order_status == "入金確認"
      order.order_details.update_all(item_status: 1)
    end
    redirect_to admins_order_path(order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
