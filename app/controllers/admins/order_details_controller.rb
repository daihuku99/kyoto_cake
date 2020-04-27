class Admins::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    array_status = order_detail.order.order_details.pluck(:item_status)
    if order_detail.item_status == "製作中"
      order_detail.order.order_status = "製作中"
      order_detail.order.update(order_status: "製作中")
    elsif array_status.count("製作完了") == order_detail.order.order_details.count
      order_detail.order.order_status = "発送準備中"
      order_detail.order.update(order_status: 3)
    end
    redirect_to admins_order_path(order_detail.order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:item_status)
  end
end
