class TaxesController < ApplicationController

	def index
		# clients_local = Client.where("country like 'egypt' or country = 'مصر'")
		# clients_foreign = Client.where.not("country like 'egypt' or country = 'مصر'")
		# purchases_local = Purchase.where(client_id: clients_local.map {|c| c.id})
		# purchases_foreign = Purchase.where(client_id: clients_foreign.map {|c| c.id})
		if params['_start'].present?
			@_start = 	Date.strptime(params['_start'], "%m/%d/%Y")
		else
			@_start = 1.month.ago
		end
		if params['_end'].present?
			@_end = Date.strptime(params['_end'], "%m/%d/%Y")
		else
			@_end = Date.today
		end

		purchases = Purchase.where("date_added > ? and date_added <= ?", @_start, @_end)

		materials_local = Material.where("date_added > ? and date_added <= ? and internal = 1", @_start, @_end)
		materials_foreign = Material.where("date_added > ? and date_added <= ? and internal = 0", @_start, @_end)

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
