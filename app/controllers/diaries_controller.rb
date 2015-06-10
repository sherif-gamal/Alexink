class DiariesController < ApplicationController

	def transactions
		@materials = Material.order(created_at: :desc)
		@expenses = Expense.order(created_at: :desc)
		@purchases = Purchase.order(created_at: :desc)
		@products = Product.all
		@clients = Client.all
		@suppliers = Supplier.all
		@raw_materials = RawMaterial.all
		if request.xhr?
      		render partial: 'transactions'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end

	def stock
		@materials = Material.order(created_at: :desc)
		@expenses = Expense.order(created_at: :desc)
		@purchases = Purchase.order(created_at: :desc)
		@products = Product.all
		@clients = Client.all
		@suppliers = Supplier.all
		@raw_materials = RawMaterial.all
		@productions = Production.all
		if request.xhr?
      		render partial: 'stock'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end

	def treasury
		@materials = Material.order(created_at: :desc)
		@expenses = Expense.order(created_at: :desc)
		@purchases = Purchase.order(created_at: :desc)
		@clients = Client.all
		@products = Product.all
		@suppliers = Product.all
		@raw_materials = RawMaterial.all
		if request.xhr?
      		render partial: 'treasury'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end

end
