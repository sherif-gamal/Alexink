class StatusController < ApplicationController
	def index
		@clients = Client.all
		@suppliers = Supplier.all
		super
	end
end
