class IncomeMenuController < ApplicationController

	def index
		if params['year'].present?
			@_year = 	params['year'].to_i
		else
			@_year = Time.now.year
		end

		@income = IncomeMenu.where(year: @_year).first
		if (!@income)
			puts "creating income"
			@income = create_new @_year 
		end

		@last_year_income = IncomeMenu.where(year: @_year - 1).first
		if (!@last_year_income)
			puts "creating last year income"
			@last_year_income = create_new @_year - 1 
		end

		super
	end

	def update
		@income = IncomeMenu.find(income_params[:id])
		@income.update(income_params)
		redirect_to "/income/#{@income.year}"
	end

	private

		def income_params
			params.require(:income_menu).permit!
		end

		def create_new(year)
      		IncomeMenu.create(sales: 0, sales_expenses: 0, sales_payoff: 0, general_expenses: 0,
      			exchange_loss: 0, ehlak: 0, exchange_profit: 0, other_income: 0, year: year)
		end

end
