class FinancialStateController < ApplicationController

		def index
		if params['year'].present?
			@_year = 	params['year'].to_i
		else
			@_year = Time.now.year
		end

		@f_state = FinancialState.where(year: @_year).first
		if (!@f_state)
			@f_state = create_new @_year 
		end

		@last_year_f_state = FinancialState.where(year: @_year - 1).first
		if (!@last_year_f_state)
			@last_year_f_state = create_new @_year - 1 
		end

		super
	end

	def update
		@financial_state = FinancialState.find(f_state_params[:id])
		@financial_state.update(f_state_params)
		redirect_to "/financial_state/#{@financial_state.year}"
	end

	private

		def f_state_params
			params.require(:financial_state).permit!
		end

		def create_new(year)
			osool = EhlakOsool.where(year: year)
			osool_value = 0
			acc_ehlak_osool = 0
			osool.each do |o|
				osool_value = osool_value + o.value
				acc_ehlak_osool = acc_ehlak_osool + o.last_year_acc
			end

      		FinancialState.create(year: year, osool: osool_value, ehlak_osool: acc_ehlak_osool)
		end

end
