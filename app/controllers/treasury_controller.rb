class TreasuryController < ApplicationController

	def update
		treasury = Treasury.first
		bank = params['bank']
		cash = params['cash']
		if is_float?(bank) && is_float?(cash) && Float(bank) >= 0 && Float(cash) >= 0
			treasury.bank = bank
			treasury.cash = cash
			treasury.save
		end
		redirect_to "/dashboard#/treasury/show"
	end

	def show
		@treasury = Treasury.first
		if request.xhr?
      		render partial: 'show'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
	end
end
