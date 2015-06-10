class StockController < ApplicationController

	def index
		@raw_materials = RawMaterial.where("in_stock > 0")
		@products = Product.where("in_stock > 0")
		super
	end

end
