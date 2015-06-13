class TreasuryController < ApplicationController

	def update
		treasury = Treasury.first
		bank = params['bank']
		cash = params['cash']
		if is_float?(bank) && is_float?(cash) && Float(bank) >= 0 && Float(cash) >= 0
			if bank != treasury.bank
				update_treasury("bank", bank.to_f - treasury.bank, MANUAL, current_user.id, "تعديل يدوي في بيانات الخزنة", 0)
			end
			if cash != treasury.cash
				update_treasury("cash", cash.to_f - treasury.cash, MANUAL, current_user.id, "تعديل يدوي في بيانات الخزنة", 0)
			end
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
