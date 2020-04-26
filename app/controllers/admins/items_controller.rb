class Admins::ItemsController < ApplicationController
	def index
		@items = Item.all
	end

	def new
		@item = Item.new
		@genres = Genre.all
	end

	def create
		item = Item.new(item_params)
		item.save
		redirect_to admins_item_path(item)
	end

	def show
		@item = Item.find(params[:id])
		@tax_ptice = @item.non_taxed_price * 1.1
	end

	def edit
		@item = Item.find(params[:id])
		@genres = Genre.all
	end

	def update
		item = Item.find(params[:id])
		genres = Genre.all
		item.update(item_params)
		redirect_to admins_item_path(item)
	end

	private
	def item_params
		params.require(:item).permit(:name, :image, :detail, :non_taxed_price, :sale_status, :genre_id, :is_valid)
	end
end
