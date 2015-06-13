class Expense < ActiveRecord::Base
	before_save :init_debt

	private
		def init_debt
			self.debt = 0
		end
end
