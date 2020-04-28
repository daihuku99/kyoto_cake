class Customers::ItemsController < ApplicationController
	def index
    @genres = Genre.all
    if params[:genre]
      genre = Genre.find(params[:genre].to_i)
      @items = genre.items
    elsif params[:sort] == "desc"
      @items = Item.all.order(id: "DESC" )
    else
      @items = Item.all
    end
	end

	def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
	end
end
