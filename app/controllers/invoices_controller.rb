class InvoicesController < ApplicationController

	def purchases
		@invoices = Invoice.all
		@products = Product.all
		@clients = Client.all
		@purchases = Purchase.all
		if request.xhr?
	      render partial: 'purchases'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end
end
