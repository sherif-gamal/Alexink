class DiariesController < ApplicationController

	def transactions
		if params['p_method'].present? && params['p_method'] != 'all'
			@p_method = params['p_method']
			materials = Material.where("p_method = ?", params['p_method'])
			expenses = Expense.where("p_method = ?", params['p_method'])
			purchases = Purchase.where("p_method = ?", params['p_method'])
		else
			@p_method = 'all'
			materials = Material.all
			expenses = Expense.all
			purchases = Purchase.all
		end
		if params['_start'].present?
			@_start = 	Date.strptime(params['_start'], "%m/%d/%Y")
		else
			@_start = 1.month.ago
		end
		if params['_end'].present?
			@_end = Date.strptime(params['_end'], "%m/%d/%Y")
		else
			@_end = DateTime.tomorrow
		end
		@materials = materials.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		@expenses = expenses.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		@purchases = purchases.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)

		@products = Product.all
		@clients = Client.all
		@suppliers = Supplier.all
		@raw_materials = RawMaterial.all
		if request.xhr?
      		render partial: 'transactions'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end

	def stock
		if params['p_method'].present? && params['p_method'] != 'all'
			@p_method = params['p_method']
			materials = Material.where("p_method = ?", params['p_method'])
			expenses = Expense.where("p_method = ?", params['p_method'])
			purchases = Purchase.where("p_method = ?", params['p_method'])
		else
			@p_method = 'all'
			materials = Material.all
			expenses = Expense.all
			purchases = Purchase.all
		end
		if params['_start'].present?
			@_start = 	Date.strptime(params['_start'], "%m/%d/%Y")
		else
			@_start = 1.month.ago
		end
		if params['_end'].present?
			@_end = Date.strptime(params['_end'], "%m/%d/%Y")
		else
			@_end = DateTime.tomorrow
		end
		@materials = materials.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		@expenses = expenses.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		@purchases = purchases.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		@products = Product.where("created_at > ? and created_at <= ?", @_start, @_end).order(created_at: :desc)
		@clients = Client.all
		@suppliers = Supplier.all
		@raw_materials = RawMaterial.all
		@productions = Production.all
		if request.xhr?
      		render partial: 'stock'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end

	def treasury
		# @materials = Material.order(date_added: :desc)
		# @expenses = Expense.order(date_added: :desc)
		# @purchases = Purchase.order(date_added: :desc)
		# @clients = Client.all
		# @products = Product.all
		# @suppliers = Supplier.all
		# @raw_materials = RawMaterial.all
		if params['p_method'].present? && params['p_method'] != 'all'
			@p_method = params['p_method']
			diaries = TreasuryDiary.where("p_method = ?", params['p_method'])
		else
			@p_method = 'all'
			diaries = TreasuryDiary.all
		end
		if params['_start'].present?
			@_start = 	Date.strptime(params['_start'], "%m/%d/%Y")
		else
			@_start = 1.month.ago
		end
		if params['_end'].present?
			@_end = Date.strptime(params['_end'], "%m/%d/%Y")
		else
			@_end = DateTime.tomorrow
		end
		diaries = diaries.where("date_added > ? and date_added <= ?", @_start, @_end)

		@treasury_additions = diaries.where("amount > ?", 0).order(date_added: :desc)
		p @treasury_additions
		@treasury_subtractions = diaries.where("amount < ?", 0).order(date_added: :desc)
		if request.xhr?
      		render partial: 'treasury'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end


	def diaries
		if params['_start'].present?
			@_start = 	Date.strptime(params['_start'], "%m/%d/%Y")
		else
			@_start = 1.month.ago
		end
		if params['_end'].present?
			@_end = Date.strptime(params['_end'], "%m/%d/%Y")
		else
			@_end = DateTime.tomorrow
		end

		puts "#{@_start}, #{@_end}"
		materials = Material.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		expenses = Expense.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)
		purchases = Purchase.where("date_added > ? and date_added <= ?", @_start, @_end).order(date_added: :desc)

		@all = materials + expenses + purchases
		@all = @all.sort_by{|e| e.date_added}

		@products = Product.all
		@clients = Client.all
		@suppliers = Supplier.all
		@raw_materials = RawMaterial.all
		if request.xhr?
      		render partial: 'diaries'
    	else
      		redirect_to "/dashboard##{request.path}"
    	end
    	flash.discard(:notice)
	end
end
