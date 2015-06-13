class TaxesController < ApplicationController

	def index
		if params['_start'].present?
			@_start = 	Date.strptime(params['_start'], "%m/%d/%Y")
		else
			@_start = 1.month.ago
		end
		if params['_end'].present?
			@_end = Date.strptime(params['_end'], "%m/%d/%Y")
		else
			@_end = 0.day.ago
		end
		taxes = TreasuryDiary.where("created_at > ? and created_at <= ? and is_tax = ?", @_start, @_end, 1).where(:transaction_type => [PURCHASE, MATERIAL])
		@debt = 0
		@credit = 0
		taxes.each do |t|
			if t.transaction_type == ApplicationController::PURCHASE
				@debt = @debt + t.amount
			else
				@credit = @credit - t.amount
			end
		end
		@debt = @debt.round(2)
		@credit = @credit.round(2)
		super
	end

end
