class Customers::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @select_address = params[:select_address]
    if @select_address == "1"
      @address = current_end_user.address
      @postcode = current_end_user.postcode
      @direction = current_end_user.first_name
    elsif @select_address == "2"
      delivery = Delivery.find(order_params[:address_id])
      @address = delivery.address
      @postcode = delivery.postcode
      @direction = delivery.direction
    else
      @address = order_params[:address]
      @postcode = order_params[:postcode]
      @direction = order_params[:direction]
    end
    # @a,@b,@c = 1,2,3
    @order = Order.new
    @order.postage = 800
    @order.tax = 1.1
    @order.payment_type = order_params[:payment_type]
    @order.total_price = current_end_user.total_price(@order.tax)
    # @order.total_price = 0
    # current_end_user.cart_items.each do |cart_item|
    #   @order.total_price += (cart_item.item.non_taxed_price * @order.tax).floor * cart_item.quantity
    # end
  end

  def create
    order = current_end_user.orders.new(order_params)
    order.postage = 800
    order.order_status = 0
    order.tax = 1.1
    if params[:select_address] == "3"
      delivery = current_end_user.deliveries.new(deli_params)
      delivery.save
    end
    if order.save
      current_end_user.cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item.id
        order_detail.price = cart_item.item.non_taxed_price
        order_detail.item_status = 0
        order_detail.quantity = cart_item.quantity
        order_detail.order_id = order.id
        order_detail.save
        # p order_detail.errors
      end
      current_end_user.cart_items.destroy_all
      redirect_to thanks_path
    else
      render :new
    end
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:address, :postcode, :direction, :payment_type, :postage, :total_price, :address_id)
  end

  def deli_params
    params.require(:order).permit(:address, :direction, :postcode)
  end

end
