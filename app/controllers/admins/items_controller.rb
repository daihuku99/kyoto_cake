class Admins::ItemsController < ApplicationController
	before_action :set_item, only: [:show, :edit, :update]
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
		@tax_ptice = @item.non_taxed_price * 1.1
	end

	def edit
		@genres = Genre.all
	end

	def update
		@item.update(item_params)
		redirect_to admins_item_path(@item)
	end

	private
	def item_params
		params.require(:item).permit(:name, :image, :detail, :non_taxed_price, :sale_status, :genre_id, :is_valid)
	end

	def set_item
		@item = Item.find(params[:id])
	end
end