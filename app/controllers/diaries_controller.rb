class DiariesController < ApplicationController

	def index
		@materials = Material.order(created_at: :desc)
		@expenses = Expense.order(created_at: :desc)
		@purchases = Purchase.order(created_at: :desc)
		@products = Product.all
		@clients = Client.all
		@suppliers = Supplier.all
		super
	end
end
