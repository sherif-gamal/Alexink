class TaxesController < ApplicationController

	def index
		# clients_local = Client.where("country like 'egypt' or country = 'مصر'")
		# clients_foreign = Client.where.not("country like 'egypt' or country = 'مصر'")
		# purchases_local = Purchase.where(client_id: clients_local.map {|c| c.id})
		# purchases_foreign = Purchase.where(client_id: clients_foreign.map {|c| c.id})

		purchases = Purchase.all

		materials_local = Material.where(internal: 1)
		materials_foreign = Material.where(internal: 0)

		# @purchases_price_local = 0
		# @purchases_price_foreign = 0
		@purchases_price = 0
		@material_price_local = 0
		@material_price_foreign = 0

		purchases.each do |p|
			@purchases_price = @purchases_price + p.price
		end

		# purchases_foreign.each do |p|
		# 	@purchases_price_foreign = @purchases_price_foreign + p.price
		# end

		materials_local.each do |m|
			@material_price_local = @material_price_local + m.price
		end

		materials_foreign.each do |m|
			@material_price_foreign = @material_price_foreign + m.price
		end

		
		@purchases_price = @purchases_price.round(2)
		# @purchases_price_foreign = @purchases_price_foreign.round(2)
		@material_price_local = @material_price_local.round(2)
		@material_price_foreign = @material_price_foreign.round(2)
		super
	end

end
