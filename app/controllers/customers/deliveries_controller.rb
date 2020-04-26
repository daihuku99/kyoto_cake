class Customers::DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:edit, :update, :destroy]
  def index
    @delivery = Delivery.new
  end

  def create
    delivery = current_end_user.deliveries.new(deli_params)
    delivery.save
    redirect_to deliveries_path
  end

  def update
    @delivery.update(deli_params)
    redirect_to deliveries_path
  end

  def destroy
    @delivery.destroy
    redirect_to deliveries_path
  end

  private
  def deli_params
    params.require(:delivery).permit(:postcode, :address, :direction)
  end

  def set_delivery
    @delivery = Delivery.find(params[:id])
  end
end
