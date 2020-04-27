class Customers::OrdersController < ApplicationController
  before_action :set_tax
  def new
    @order = Order.new
  end

  def confirm
    @select_address = params[:select_address]
    if @select_address == "1"
      @address,@postcode,@direction = current_end_user.address,current_end_user.postcode,current_end_user.first_name
    elsif @select_address == "2"
      delivery = Delivery.find(order_params[:address_id])
      @address,@postcode,@direction = delivery.address,delivery.postcode,delivery.direction
    else
      @address,@postcode,@direction = order_params[:address],order_params[:postcode],order_params[:direction]
    end
    @order = Order.new
    @order.postage = 800
    @order.tax = 1.1
    @order.payment_type = order_params[:payment_type]
    @order.total_price = current_end_user.total_price(@order.tax) #total_priceはend_user.rbのインスタンスメソッド
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
        # p order_detail.errors(デバックの方法)
      end
      current_end_user.cart_items.destroy_all
      redirect_to thanks_path
    else
      render :new
    end
  end

  def index
    @orders = current_end_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:address, :postcode, :direction, :payment_type, :postage, :total_price, :address_id)
  end

  def deli_params
    params.require(:order).permit(:address, :direction, :postcode)
  end

end
