class Customers::OrdersController < ApplicationController
  before_action :set_tax
  def new
    @order = Order.new
  end

  def confirm
    @select_address = params[:select_address]
    case  @select_address
    when "1"
      @address,@postcode,@direction = current_end_user.address,current_end_user.postcode,current_end_user.first_name
    when "2"
      delivery = Delivery.find(order_params[:address_id])
      @address,@postcode,@direction = delivery.address,delivery.postcode,delivery.direction
    when "3"
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
      delivery = current_end_user.deliveries.create(deli_params)
    end
    if order.new_order(current_end_user)
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
