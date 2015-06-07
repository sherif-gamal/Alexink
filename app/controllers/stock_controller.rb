class StockController < ApplicationController

	def index
		@materials = Material.where("in_stock > 0")
		@products = Product.where("in_stock > 0")
		super
	end

end
